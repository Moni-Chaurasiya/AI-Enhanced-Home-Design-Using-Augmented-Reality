import 'package:flutter/material.dart';
import 'package:visionaryhome/screens/home/components/favorite.dart';
import 'package:visionaryhome/screens/home/home_screen.dart';
import '../../../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            // Changed Icon to IconButton for navigation
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const HomeScreen()), // Corrected the builder function
              );
            },
            icon: const Icon(Icons.arrow_circle_right), // icon
            iconSize: 25, //icon size
          ),
          const Text(
            // Moved "Explore" text
            'Explore',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          IconButton(
            // Changed Icon to IconButton for navigation
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const FavoriteScreen()), // Corrected the builder function
              );
            },
            icon: const Icon(Icons.favorite), // Icon of favorite
            iconSize: 25,
          ),
        ],
      ),
    );
  }
}
