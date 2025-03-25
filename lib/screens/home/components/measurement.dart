//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../Mes2.dart';

class MeasurementHomePage extends StatelessWidget {
  const MeasurementHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Home/ARMeasurement.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                'Measure Your Space Accurately',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  FeatureItem(
                    icon: Icons.straighten,
                    title: 'Precise Measurements',
                    description:
                        'Use AR technology to measure dimensions accurately.',
                  ),
                  FeatureItem(
                    icon: Icons.linear_scale_sharp,
                    title: 'Real-Time Calculations',
                    description:
                        'Get instant measurements with AR-based tools.',
                  ),
                  FeatureItem(
                    icon: Icons.design_services,
                    title: 'Seamless Integration',
                    description:
                        'Apply accurate measurements directly to your designs.',
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          const Mes(value: "assets/s14/chair.gltf")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 34, 84),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Start Measuring in AR'),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '© 2025 VisionaryHome. All rights reserved.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  FeatureItem(
      {required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 40, color: const Color.fromARGB(255, 1, 34, 84)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 1, 34, 84)),
                ),
                Text(
                  description,
                  style: const TextStyle(
                      fontSize: 14, color: Color.fromARGB(255, 1, 34, 84)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
