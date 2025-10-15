import 'dart:io';
import 'package:clothes_ecommerce_app/core/const/app_const.dart';
import 'package:clothes_ecommerce_app/feature/auth/data/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabaseClient;
  final GoogleSignIn googleSignIn;

  AuthService({
    required this.supabaseClient,
    required this.googleSignIn,
  });

  // Sign up with email
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final metadata = displayName != null
        ? {
            'display_name': displayName,
          }
        : null;

    await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: metadata,
      emailRedirectTo: null,
    );
  }

  // Verify email OTP
  Future<UserModel> verifyEmailOTP({
    required String email,
    required String token,
  }) async {
    final response = await supabaseClient.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.signup,
    );

    if (response.user == null) {
      throw Exception('Verification failed');
    }

    // Get user profile from profiles table
    return await _getUserProfile(response.user!.id);
  }

  // Resend verification code
  Future<void> resendVerificationCode(String email) async {
    await supabaseClient.auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }

  // Sign in with email
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Sign in failed');
    }

    // Get user profile from profiles table
    return await _getUserProfile(response.user!.id);
  }

  // Sign in with Google
  Future<UserModel> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign in cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw Exception('Failed to get Google credentials');
    }

    final response = await supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    if (response.user == null) {
      throw Exception('Google sign in failed');
    }

    // Get user profile from profiles table
    return await _getUserProfile(response.user!.id);
  }

  // Sign in with Apple
  Future<UserModel> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw Exception('Failed to get Apple credentials');
    }

    final response = await supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
    );

    if (response.user == null) {
      throw Exception('Apple sign in failed');
    }

    // Get user profile from profiles table
    return await _getUserProfile(response.user!.id);
  }

  // Send password reset code
  Future<void> sendPasswordResetCode(String email) async {
    await supabaseClient.auth.resetPasswordForEmail(email);
  }

  // Verify password reset code
  Future<void> verifyPasswordResetCode({
    required String email,
    required String token,
  }) async {
    await supabaseClient.auth.verifyOTP(
      email: email,
      token: token,
      type: OtpType.recovery,
    );
  }

  // Reset password
  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    // First verify the OTP
    await verifyPasswordResetCode(email: email, token: token);

    // Then update the password
    await supabaseClient.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  // Upload profile photo
  Future<String> uploadProfilePhoto({
    required String userId,
    required String filePath,
  }) async {
    final file = File(filePath);
    final fileExt = filePath.split('.').last;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final storagePath = 'avatars/$userId/$fileName';

    await supabaseClient.storage.from(AppConst.tabelProfileUser).upload(
          storagePath,
          file,
          fileOptions: const FileOptions(
            upsert: true,
            contentType: 'image/*',
          ),
        );

    final photoUrl = supabaseClient.storage
        .from(AppConst.tabelProfileUser)
        .getPublicUrl(storagePath);

    // Update profiles table
    await supabaseClient
        .from(AppConst.tabelProfileUser)
        .update({'avatar_url': photoUrl}).eq('id', userId);

    return photoUrl;
  }

  // Delete profile photo
  Future<void> deleteProfilePhoto(String userId) async {
    // Get current avatar URL
    final response = await supabaseClient
        .from(AppConst.tabelProfileUser)
        .select('avatar_url')
        .eq('id', userId)
        .single();

    final photoUrl = response['avatar_url'] as String?;

    if (photoUrl != null) {
      // Extract file path from URL
      final uri = Uri.parse(photoUrl);
      final path = uri.pathSegments.skip(3).join('/');

      // Delete from storage
      await supabaseClient.storage
          .from(AppConst.tabelProfileUser)
          .remove([path]);

      // Update profiles table
      await supabaseClient
          .from(AppConst.tabelProfileUser)
          .update({'avatar_url': null}).eq('id', userId);
    }
  }

  // Update user profile
  Future<UserModel> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');

    final data = <String, dynamic>{};
    if (displayName != null) data['display_name'] = displayName;
    if (photoUrl != null) data['avatar_url'] = photoUrl;

    // Update profiles table
    await supabaseClient
        .from(AppConst.tabelProfileUser)
        .update(data)
        .eq('id', userId);

    // Get updated profile
    return await _getUserProfile(userId);
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) return null;

    return await _getUserProfile(user.id);
  }

  // Sign out
  Future<void> signOut() async {
    await googleSignIn.signOut();
    await supabaseClient.auth.signOut();
  }

  // Delete account
  Future<void> deleteAccount() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    // Delete profile photo if exists
    try {
      await deleteProfilePhoto(user.id);
    } catch (_) {}

    // Call Supabase function to delete user (will cascade delete profile)
    await supabaseClient.rpc('delete_user');

    // Sign out
    await signOut();
  }

  // Auth state changes stream
  Stream<UserModel?> get authStateChanges {
    return supabaseClient.auth.onAuthStateChange.asyncMap((event) async {
      final user = event.session?.user;
      if (user == null) return null;

      try {
        return await _getUserProfile(user.id);
      } catch (e) {
        return null;
      }
    });
  }

  // Private helper: Get user profile from profiles table
  Future<UserModel> _getUserProfile(String userId) async {
    final response = await supabaseClient
        .from(AppConst.tabelProfileUser)
        .select()
        .eq('id', userId)
        .single();

    return UserModel.fromJson(response);
  }
}
