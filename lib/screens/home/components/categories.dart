import 'package:flutter/material.dart';
//import '../../../constants/constants.dart';
//import '../../../data/data.dart';
import '../../../data/fetch.dart';

class Categories extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const Categories({
    Key? key,
    required this.selectedIndex,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Color.fromARGB(255, 1, 34, 84)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: selectedIndex == index
                      ? Colors.transparent
                      : Color.fromARGB(255, 1, 34, 84),
                ),
              ),
              child: Center(
                child: Text(
                  categoryList[index],
                  style: TextStyle(
                    color: selectedIndex == index
                        ? Colors.white
                        : Color.fromARGB(255, 1, 34, 84),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
