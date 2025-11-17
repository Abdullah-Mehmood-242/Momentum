import 'package:flutter/material.dart';
import 'package:momentum/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:momentum/features/profile/presentation/screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201A3F),
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                // backgroundImage: AssetImage('assets/images/profile_pic.png'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Abdullah Mehmood',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'abdullahmehmood242@gmail.com',
                style: TextStyle(color: Colors.white54, fontSize: 16),
              ),
              const SizedBox(height: 30),
              _buildProfileDetailCard(title: 'Weight', value: '145 lbs'),
              const SizedBox(height: 16),
              _buildProfileDetailCard(title: 'Height', value: '5\'6"'),
              const SizedBox(height: 16),
              _buildProfileDetailCard(title: 'Age', value: '30'),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'View/Edit My Goals',
                    style: TextStyle(
                      color: Color(0xFF201A3F),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetailCard({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3D7E),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
