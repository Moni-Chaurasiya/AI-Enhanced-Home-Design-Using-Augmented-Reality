import 'package:flutter/material.dart';
import 'category_dialog1.dart';
import '../constants/fetch.dart';

class CategorySelector extends StatelessWidget {
  final Function(List<Item>) onCategorySelected;

  const CategorySelector({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.menu),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => CategoryDialog(
            onCategorySelected: onCategorySelected,
          ),
        );
      },
    );
  }
}
