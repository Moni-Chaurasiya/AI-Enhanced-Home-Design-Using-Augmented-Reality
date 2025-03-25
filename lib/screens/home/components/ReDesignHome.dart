import 'package:flutter/material.dart';
import 'ReDesign.dart';

class ReDesignHome extends StatelessWidget {
  const ReDesignHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Home/ReDesign.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Text(
                'ReDesign Your Interior Home',
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
                    icon: Icons.upload,
                    title: 'Upload Interior Image',
                    description:
                        'Provide an image of your space to get personalized design suggestions.',
                  ),
                  FeatureItem(
                    icon: Icons.lightbulb,
                    title: 'AI-Powered Suggestions',
                    description:
                        'Receive intelligent design recommendations based on your uploaded image.',
                  ),
                  FeatureItem(
                    icon: Icons.image,
                    title: 'Generate Visuals',
                    description:
                        'See a rendered preview of your suggested interior design.',
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
                  MaterialPageRoute(builder: (_) => const ReDesign()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 34, 84),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Start ReDesigning using AI'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
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



// // import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'ReDesign.dart'; // Ensure this import points to your new file

// class ReDesignHome extends StatelessWidget {
//   const ReDesignHome({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Container(
//             height: 200,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                     'assets/Home/ARMeasurement.png'), // Make sure this asset exists
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Container(
//               // Added a container for better text visibility
//               color: Colors.black.withOpacity(0.3),
//               alignment: Alignment.center,
//               child: const Text(
//                 'ReDesign Your Interior Home',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   shadows: [Shadow(blurRadius: 5, color: Colors.black)],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const <Widget>[
//                   FeatureItem(
//                     icon: Icons.camera_alt,
//                     title: 'Upload Interior Image',
//                     description:
//                         'Provide an image of your space to get personalized design suggestions.',
//                   ),
//                   SizedBox(height: 15),
//                   FeatureItem(
//                     icon: Icons.lightbulb_outline,
//                     title: 'AI-Powered Suggestions',
//                     description:
//                         'Receive intelligent text-based design recommendations based on your image.',
//                   ),
//                   SizedBox(height: 15),
//                   FeatureItem(
//                     icon: Icons.room_preferences_outlined,
//                     title: 'Specify Room Type',
//                     description:
//                         'Tell our AI the type of room (e.g., library) for tailored advice.',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => const ReDesign()), // Navigate to ReDesign
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 1, 34, 84),
//                 foregroundColor: Colors.white,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
//                 textStyle:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 minimumSize:
//                     const Size(double.infinity, 50), // Make button wider
//               ),
//               child: const Text('Start ReDesigning with AI'),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(bottom: 20.0),
//             child: Text(
//               '© 2025 VisionaryHome. All rights reserved.',
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FeatureItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String description;

//   const FeatureItem(
//       {super.key,
//       required this.icon,
//       required this.title,
//       required this.description});

//   @override
//   Widget build(BuildContext context) {
//     const color = Color.fromARGB(255, 1, 34, 84);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Icon(icon, size: 35, color: color),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   title,
//                   style: const TextStyle(
//                       fontSize: 17, fontWeight: FontWeight.bold, color: color),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   description,
//                   style: const TextStyle(fontSize: 14, color: Colors.black54),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
