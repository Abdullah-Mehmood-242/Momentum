import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hello, Abdullah', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              Row(
                children: [
                  _buildCircularProgress(),
                  const SizedBox(width: 30),
                  _buildActivityStats(),
                ],
              ),
              const SizedBox(height: 40),
              const Text('Recommended Workouts:', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildWorkoutRecommendations(),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A3D7E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),
                  child: const Text('Start Workout', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularProgress() {
    return CircularPercentIndicator(
      radius: 70.0,
      lineWidth: 10.0,
      percent: 0.0,
      center: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('0%', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          Text("Today's Activity", style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
      progressColor: Colors.white,
      backgroundColor: const Color(0xFF4A3D7E),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  Widget _buildActivityStats() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Calories Burnt: 0 kcal', style: TextStyle(color: Colors.white, fontSize: 16)),
        SizedBox(height: 10),
        Text('Steps: 0', style: TextStyle(color: Colors.white, fontSize: 16)),
        SizedBox(height: 10),
        Text('Active Minutes: 0 min', style: TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  Widget _buildWorkoutRecommendations() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Placeholder for workout images
        WorkoutCard(title: 'Warm Up', duration: '30 min', level: 'Basic', image: 'assets/images/warm_up.png'),
        WorkoutCard(title: 'Full Body', duration: '2 Hrs', level: 'Advanced', image: 'assets/images/full_body.png'),
      ],
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final String title, duration, level, image;

  const WorkoutCard({super.key, required this.title, required this.duration, required this.level, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF4A3D7E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 150,
        height: 200,
        child: Column(
          children: [
            // Image.asset(image, fit: BoxFit.cover, height: 120, width: double.infinity),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(duration, style: const TextStyle(color: Colors.white54, fontSize: 14)),
                  const SizedBox(height: 5),
                  Text(level, style: const TextStyle(color: Colors.white54, fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
