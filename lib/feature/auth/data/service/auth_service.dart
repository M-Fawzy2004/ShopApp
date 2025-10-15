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

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: displayName != null ? {'display_name': displayName} : null,
      emailRedirectTo: null,
    );
  }

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

    final displayName = response.user!.userMetadata?['display_name'] as String?;

    final profileData = {
      'id': response.user!.id,
      'email': response.user!.email,
      'display_name': displayName,
      'avatar_url': null,
      'created_at': DateTime.now().toIso8601String(),
    };

    await supabaseClient.from(AppConst.tabelProfileUser).upsert(profileData);

    return await getUserProfile(response.user!.id);
  }

  Future<void> resendVerificationCode(String email) async {
    await supabaseClient.auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }

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

    return await getUserProfile(response.user!.id);
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }

      final googleAuth = await googleUser.authentication;

      final response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      if (response.user == null) {
        throw Exception('Failed to sign in with Google');
      }

      return await getUserProfile(response.user!.id);
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
  }

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

    return await getUserProfile(response.user!.id);
  }

  Future<void> sendPasswordResetCode(String email) async {
    await supabaseClient.auth.resetPasswordForEmail(email);
  }

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

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    await verifyPasswordResetCode(email: email, token: token);

    await supabaseClient.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

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

    await supabaseClient
        .from(AppConst.tabelProfileUser)
        .update({'avatar_url': photoUrl}).eq('id', userId);

    return photoUrl;
  }

  Future<void> deleteProfilePhoto(String userId) async {
    final response = await supabaseClient
        .from(AppConst.tabelProfileUser)
        .select('avatar_url')
        .eq('id', userId)
        .single();

    final photoUrl = response['avatar_url'] as String?;

    if (photoUrl != null) {
      final uri = Uri.parse(photoUrl);
      final path = uri.pathSegments.skip(3).join('/');

      await supabaseClient.storage
          .from(AppConst.tabelProfileUser)
          .remove([path]);

      await supabaseClient
          .from(AppConst.tabelProfileUser)
          .update({'avatar_url': null}).eq('id', userId);
    }
  }

  Future<UserModel> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) throw Exception('No user logged in');

    final data = <String, dynamic>{};
    if (displayName != null) data['display_name'] = displayName;
    if (photoUrl != null) data['avatar_url'] = photoUrl;

    await supabaseClient
        .from(AppConst.tabelProfileUser)
        .update(data)
        .eq('id', userId);

    return await getUserProfile(userId);
  }

  Future<UserModel?> getCurrentUser() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) return null;

    return await getUserProfile(user.id);
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
    await supabaseClient.auth.signOut();
  }

  Future<void> deleteAccount() async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    try {
      await deleteProfilePhoto(user.id);
    } catch (_) {}

    await supabaseClient.rpc('delete_user');

    await signOut();
  }

  Stream<UserModel?> get authStateChanges {
    return supabaseClient.auth.onAuthStateChange.asyncMap((event) async {
      final user = event.session?.user;
      if (user == null) return null;

      try {
        return await getUserProfile(user.id);
      } catch (e) {
        return null;
      }
    });
  }

  Future<UserModel> getUserProfile(String userId) async {
    final response = await supabaseClient
        .from(AppConst.tabelProfileUser)
        .select()
        .eq('id', userId)
        .single();

    return UserModel.fromJson(response);
  }
}
