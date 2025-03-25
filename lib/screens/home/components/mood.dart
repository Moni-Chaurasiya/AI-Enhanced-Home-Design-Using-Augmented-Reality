//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'moodScreen.dart';

class MoodHomePage extends StatelessWidget {
  const MoodHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Home/mood.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                'Discover Your Mood',
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
                    icon: Icons.mood,
                    title: 'Reflect Your Emotion',
                    description:
                        'Choose your mood and see how it transforms your experience.',
                  ),
                  FeatureItem(
                    icon: Icons.music_note,
                    title: 'Tune Into Your Vibes',
                    description:
                        'Let your mood dictate the perfect soundtrack for your day.',
                  ),
                  FeatureItem(
                    icon: Icons.palette,
                    title: 'Colors of Emotion',
                    description:
                        'Watch your mood bring a burst of color to your surroundings.',
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
                  MaterialPageRoute(builder: (context) => const MoodScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 34, 84),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Experience Your Mood'),
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
