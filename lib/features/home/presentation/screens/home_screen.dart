import 'package:flutter/material.dart';
import 'package:momentum/core/state/app_state.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:momentum/features/workouts/presentation/screens/workout_detail_screen.dart';
import 'package:momentum/features/profile/presentation/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final userName = appState.userName;
    final todayProgress = appState.todayProgress;
    final activityPercent = appState.todayActivityPercent;
    final workouts = appState.workouts;

    return Scaffold(
      backgroundColor: const Color(0xFF201A3F),
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Home', style: TextStyle(color: Colors.white)),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $userName',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  _buildCircularProgress(activityPercent),
                  const SizedBox(width: 30),
                  _buildActivityStats(todayProgress),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Recommended Workouts:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildWorkoutRecommendations(context, workouts),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularProgress(double percent) {
    final percentInt = (percent * 100).toInt();
    return CircularPercentIndicator(
      radius: 70.0,
      lineWidth: 10.0,
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$percentInt%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Today's Activity",
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
      progressColor: const Color(0xFFE8FF78),
      backgroundColor: const Color(0xFF4A3D7E),
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 1000,
    );
  }

  Widget _buildActivityStats(dynamic todayProgress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calories Burnt: ${todayProgress.caloriesBurnt} kcal',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          'Steps: ${todayProgress.steps}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          'Active Minutes: ${todayProgress.activeMinutes} min',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildWorkoutRecommendations(BuildContext context, List workouts) {
    // Take first 2 workouts as recommendations
    final recommendations = workouts.take(2).toList();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: recommendations.map((workout) {
        return WorkoutCard(
          title: workout.title,
          duration: workout.duration,
          level: workout.level,
          image: workout.image,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutDetailScreen(workout: workout),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final String title, duration, level, image;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.duration,
    required this.level,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF4A3D7E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: 150,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF3A2D6E),
                      child: const Center(
                        child: Icon(
                          Icons.fitness_center,
                          color: Colors.white54,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      duration,
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                    Text(
                      level,
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
