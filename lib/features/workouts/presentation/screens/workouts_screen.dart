import 'package:flutter/material.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201A3F),
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text('Workout', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: const [
                  WorkoutCard(title: 'Warm Up', duration: '30 min', level: 'Basic', image: 'assets/images/warm_up.png'),
                  SizedBox(height: 16),
                  WorkoutCard(title: 'Full Body', duration: '3 hrs', level: 'Advanced', image: 'assets/images/full_body.png'),
                  SizedBox(height: 16),
                  WorkoutCard(title: 'Yoga Flow', duration: '1 hrs', level: 'Intermediate', image: 'assets/images/yoga_flow.png'),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search all Workouts',
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.search, color: Colors.white54),
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF4A3D7E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final String title, duration, level, image;

  const WorkoutCard({super.key, required this.title, required this.duration, required this.level, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          // Image.asset(image, fit: BoxFit.cover, height: 180, width: double.infinity, color: Colors.black.withOpacity(0.3), colorBlendMode: BlendMode.darken),
          Container(height: 180, decoration: BoxDecoration(color: Colors.black.withOpacity(0.3))),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(duration, style: const TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(height: 5),
                Text(level, style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
