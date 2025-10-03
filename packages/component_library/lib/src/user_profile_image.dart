import 'package:flutter/material.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
    required this.photoURL,
    required this.onEditProfilePictureTapped,
  });

  final String? photoURL;
  final VoidCallback? onEditProfilePictureTapped;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundImage: photoURL != null ? NetworkImage(photoURL!) : null,
          child: photoURL == null ? const Icon(Icons.person, size: 50) : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onEditProfilePictureTapped,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 2,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
