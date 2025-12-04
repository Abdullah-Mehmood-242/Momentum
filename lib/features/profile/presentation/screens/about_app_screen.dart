import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

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
        title: const Text('About', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // App Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A3D7E),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE8FF78).withAlpha(50),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.fitness_center,
                        size: 60,
                        color: Color(0xFFE8FF78),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // App Name
              const Text(
                'Momentum',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Version
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8FF78),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: Color(0xFF201A3F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Tagline
              const Text(
                'Your Personal Fitness Companion',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              // Description Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A3D7E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Momentum is a comprehensive fitness tracking app designed to help you achieve your health and wellness goals. Track workouts, monitor progress, and stay motivated on your fitness journey.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              // Features
              _buildFeatureItem(Icons.fitness_center, 'Track Workouts', 'Log and monitor your exercise sessions'),
              _buildFeatureItem(Icons.insights, 'View Progress', 'Visualize your fitness journey over time'),
              _buildFeatureItem(Icons.emoji_events, 'Earn Achievements', 'Celebrate milestones and personal bests'),
              _buildFeatureItem(Icons.person, 'Personalized Experience', 'Tailored to your fitness profile'),
              const SizedBox(height: 40),
              // Developer Info
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A3D7E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Developed by Abdullah Mehmood with ❤️',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '© 2024 Momentum. All rights reserved.',
                      style: TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(Icons.language, 'Website'),
                        const SizedBox(width: 16),
                        _buildSocialButton(Icons.alternate_email, 'Twitter'),
                        const SizedBox(width: 16),
                        _buildSocialButton(Icons.camera_alt, 'Instagram'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Tech Stack
              const Text(
                'Built with Flutter',
                style: TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flutter_dash, color: Colors.blue[300], size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    '& Firebase',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.local_fire_department, color: Colors.orange[300], size: 24),
                ],
              ),
              const SizedBox(height: 40),
              // Legal Links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  const Text(' | ', style: TextStyle(color: Colors.white54)),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms of Service',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF4A3D7E),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF201A3F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFFE8FF78)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF201A3F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
