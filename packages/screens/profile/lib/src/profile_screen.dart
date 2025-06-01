import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // Dummy Data for Demonstration
  final String _profileName = 'Olivia Bennett';
  final String _profileMemberSince = '+232 78 654 321';
  final String _profilePicUrl = 'https://picsum.photos/id/1011/200/200';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
            print('Back button pressed');
          },
        ),
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(
              profileImageUrl: _profilePicUrl,
              userName: _profileName,
              phoneNumber: _profileMemberSince,
            ),

            SectionTitle(title: 'Account'),
            ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Saved Addresses'),
              onTap: () => print(('Saved Addresses tapped')),
            ),

            ListTile(
              leading: Icon(Icons.credit_card_outlined),
              title: Text('Payment Methods'),
              onTap: () => print('Payment Methods tapped'),
            ),

            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text('Favorites'),
              onTap: () => print('Favorites tapped'),
            ),

            // Orders Section
            SectionTitle(title: 'Orders'),
            ListTile(
              leading: Icon(Icons.archive_outlined),
              title: Text('Order #789012'),

              subtitle: Text('Delivered'),
              onTap: () => print('Order #123456 tapped'),
            ),
            ListTile(
              leading: Icon(Icons.archive_outlined),
              title: Text('Order #123456'),
              subtitle: Text('Shipped'),
              onTap: () => print('Order #789012 tapped'),
            ),
          ],
        ),
      ),
    );
  }
}
