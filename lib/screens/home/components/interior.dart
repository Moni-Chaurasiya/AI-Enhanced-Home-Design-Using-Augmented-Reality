//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//import '../../../Ar_Designn.dart';
import '../../../Ar_interior2.dart';
//import '../../../Ar_interior3.dart';

class InteriorHomePage extends StatelessWidget {
  const InteriorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Home/ARImg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                'Create Your Dream Space',
                style: TextStyle(
                  color: Colors.black,
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
                    icon: Icons.chair,
                    title: 'Modern Furniture',
                    description:
                        'Explore a wide range of modern furniture pieces.',
                  ),
                  FeatureItem(
                    icon: Icons.palette,
                    title: 'Customizable Designs',
                    description:
                        'Personalize every detail to match your style.',
                  ),
                  FeatureItem(
                    icon: Icons.vrpano,
                    title: 'Real-Time AR Preview',
                    description:
                        'See your design come to life in Augmented Reality.',
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
                  MaterialPageRoute(builder: (context) => const AR_Sessionn()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 34, 84),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Start Designing in AR'),
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
