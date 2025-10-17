import 'package:clothes_ecommerce_app/feature/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

/// Helper class to get user data from UserEntity
class UserDataHelper {
  final UserEntity? user;

  UserDataHelper(this.user);

  /// Get user display name or fallback to email
  String get displayName {
    if (user == null) return 'Guest';

    if (user!.displayName != null && user!.displayName!.isNotEmpty) {
      return user!.displayName!;
    }

    // Extract name from email if display name is not available
    if (user!.email.isNotEmpty) {
      return user!.email.split('@').first;
    }

    return 'User';
  }

  /// Get user email
  String get email {
    return user?.email ?? 'No email';
  }

  /// Get user photo URL
  String? get photoUrl {
    return user?.photoUrl;
  }

  /// Check if user has profile photo
  bool get hasPhoto {
    return photoUrl != null && photoUrl!.isNotEmpty;
  }

  /// Get initials from user name (first 1-2 characters)
  String get initials {
    if (user == null) return 'G';

    final name = displayName.trim();

    if (name.isEmpty) return 'U';

    // Split by spaces to get first and last name
    final nameParts = name.split(' ').where((part) => part.isNotEmpty).toList();

    if (nameParts.isEmpty) return 'U';

    if (nameParts.length == 1) {
      // Single name: take first 2 characters or 1 if name is too short
      return nameParts[0]
          .substring(0, nameParts[0].length >= 2 ? 2 : 1)
          .toUpperCase();
    }

    // Multiple names: take first character of first and last name
    return '${nameParts.first[0]}${nameParts.last[0]}'.toUpperCase();
  }

  /// Get user ID
  String get userId {
    return user?.id ?? '';
  }

  /// Check if user is logged in
  bool get isLoggedIn {
    return user != null;
  }

  /// Get greeting based on time of day
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  /// Get color for avatar based on user name
  Color getAvatarColor() {
    if (user == null) return Colors.grey;

    final colors = [
      const Color(0xFF1976D2), // Blue
      const Color(0xFF388E3C), // Green
      const Color(0xFFD32F2F), // Red
      const Color(0xFFF57C00), // Orange
      const Color(0xFF7B1FA2), // Purple
      const Color(0xFF0097A7), // Cyan
      const Color(0xFFC2185B), // Pink
      const Color(0xFF5D4037), // Brown
    ];

    // Generate color based on user ID or name hash
    final hash = userId.isNotEmpty ? userId.hashCode : displayName.hashCode;

    return colors[hash.abs() % colors.length];
  }
}

/// Extension on BuildContext to easily access user data
extension UserDataContext on BuildContext {
  UserDataHelper get userData {
    // You would typically get the user from BlocProvider here
    // This is just a helper method
    return UserDataHelper(null);
  }
}

