import 'package:flutter/material.dart';
import 'package:momentum/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:momentum/features/auth/presentation/screens/welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Account', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildSettingsCard(
              icon: Icons.person,
              title: 'Personal Information',
              subtitle: 'Abdullah, abdullahmehmood242@gmai.com',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            _buildSettingsCard(
              icon: Icons.security,
              title: 'Security',
              subtitle: 'Change Password',
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            _buildNotificationSetting(),
            const SizedBox(height: 30),
            const Text('Support & Legal', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildSettingsCard(
              icon: Icons.help_center,
              title: 'Help Center',
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            _buildSettingsCard(
              icon: Icons.article,
              title: 'Terms and Conditions',
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              onTap: () {},
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _showLogoutDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A3D7E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
                child: const Text('Logout', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required IconData icon, required String title, String? subtitle, Widget? trailing, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF4A3D7E),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ],
            ),
            const Spacer(),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSetting() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3D7E),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications, color: Colors.white),
          const SizedBox(width: 16),
          const Text('Notifications', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const Spacer(),
          Switch(value: true, onChanged: (bool value) {}, activeColor: Colors.white, activeTrackColor: Colors.green, inactiveThumbColor: Colors.white, inactiveTrackColor: Colors.grey),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF4A3D7E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Are You Sure?', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text('Yes', style: TextStyle(color: Color(0xFF201A3F), fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('no', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
