import 'package:clothes_ecommerce_app/feature/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.photoUrl,
    required super.emailVerified,
    super.phoneNumber,
    super.createdAt,
    super.lastSignIn,
  });

  // From profiles table in Supabase
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String?,
      photoUrl: json['avatar_url'] as String?,
      emailVerified: json['email_verified'] as bool? ?? false,
      phoneNumber: json['phone_number'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      lastSignIn: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  // To profiles table format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'display_name': displayName,
      'avatar_url': photoUrl,
      'email_verified': emailVerified,
      'phone_number': phoneNumber,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': lastSignIn?.toIso8601String(),
    };
  }

  // Legacy support - لو محتاج تستخدم auth.users metadata
  factory UserModel.fromSupabaseAuth(Map<String, dynamic> authData) {
    final user = authData['user'];
    return UserModel(
      id: user['id'] as String,
      email: user['email'] as String,
      displayName: user['user_metadata']?['display_name'] as String?,
      photoUrl: user['user_metadata']?['avatar_url'] as String?,
      emailVerified: user['email_confirmed_at'] != null,
      phoneNumber: user['phone'] as String?,
      createdAt: user['created_at'] != null
          ? DateTime.parse(user['created_at'] as String)
          : null,
      lastSignIn: user['last_sign_in_at'] != null
          ? DateTime.parse(user['last_sign_in_at'] as String)
          : null,
    );
  }

  // Create a copy with updated values
  @override
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? emailVerified,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? lastSignIn,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      lastSignIn: lastSignIn ?? this.lastSignIn,
    );
  }
}