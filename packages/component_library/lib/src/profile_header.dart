import 'package:flutter/material.dart';

/// Displays the user's profile picture, name, and membership status.
class ProfileHeader extends StatelessWidget {
  final String profileImageUrl;
  final String userName;
  final String phoneNumber;

  const ProfileHeader({
    super.key,
    required this.profileImageUrl,
    required this.userName,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48, // Size of the profile picture
              backgroundColor: Colors.grey[200], // Placeholder background
              backgroundImage: NetworkImage(profileImageUrl),
              onBackgroundImageError: (exception, stackTrace) {
                // Fallback for image loading errors
                print('Error loading image: $exception');
              },
              child:
                  (profileImageUrl
                      .isEmpty) // Show fallback icon if no image URL
                  ? const Icon(Icons.person, size: 60, color: Colors.grey)
                  : null,
            ),
            const SizedBox(height: 16.0),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              phoneNumber,
              style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
