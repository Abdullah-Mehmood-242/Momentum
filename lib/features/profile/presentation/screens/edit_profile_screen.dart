import 'package:flutter/material.dart';
import 'package:momentum/features/profile/presentation/screens/settings_screen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
        title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
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
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    // backgroundImage: AssetImage('assets/images/profile_pic.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildTextField(label: 'Name', initialValue: 'Abdullah'),
              const SizedBox(height: 16),
              _buildTextField(label: 'Email', initialValue: 'abdullahmehmood@gmail.com'),
              const SizedBox(height: 16),
              _buildDateField(),
              const SizedBox(height: 16),
              _buildMeasurementField(label: 'Height', value: "5\'6\"", units: ['in/cm']),
              const SizedBox(height: 16),
              _buildMeasurementField(label: 'Weight', value: '145lbs', units: ['lbs/kg']),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text('Save', style: TextStyle(color: Color(0xFF201A3F), fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required String initialValue}) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            initialValue: initialValue,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF4A3D7E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Row(
      children: [
        const Text('Date of Birth', style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFF4A3D7E),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: const Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text('mm/DD/yy', style: TextStyle(color: Colors.white54, fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeasurementField({required String label, required String value, required List<String> units}) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF4A3D7E),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.white, size: 20), // Placeholder
                const SizedBox(width: 10),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
                const Spacer(),
                DropdownButton<String>(
                  value: units.first,
                  dropdownColor: const Color(0xFF4A3D7E),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  items: units.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
