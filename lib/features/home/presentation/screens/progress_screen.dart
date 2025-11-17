import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

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
        title: const Text('Progress', style: TextStyle(color: Colors.white)),
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
              _buildTimeToggle(),
              const SizedBox(height: 30),
              const Text('Weight Trend', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildChart(),
              const SizedBox(height: 30),
              const Text('Achievements', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildAchievements(),
              const SizedBox(height: 30),
              const Text('Personal Bests', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildPersonalBests(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildToggleButton('Week', true),
        _buildToggleButton('Month', false),
        _buildToggleButton('Year', false),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF4A3D7E) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: isSelected ? BorderSide.none : const BorderSide(color: Color(0xFF4A3D7E)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 1.5),
                const FlSpot(2, 1.4),
                const FlSpot(3, 3.4),
                const FlSpot(4, 2),
                const FlSpot(5, 2.2),
                const FlSpot(6, 1.8),
              ],
              isCurved: true,
              color: Colors.cyan,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard('Workout Completed', '19 This Month'),
        _buildStatCard('Total Active Time', '26 hours 49 mins'),
      ],
    );
  }

  Widget _buildPersonalBests() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatCard('Fastest 5 km Run', '45 mins'),
        _buildStatCard('Heaviest Deadlift', '100 kg'),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3D7E),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 14)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
