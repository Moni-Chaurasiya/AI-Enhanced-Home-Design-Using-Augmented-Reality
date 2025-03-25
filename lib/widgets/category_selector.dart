/*
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import 'category_dialog.dart';

class CategorySelector extends StatelessWidget {
  final Function(List<DetailModel>) onCategorySelected;

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
*/

import 'package:flutter/material.dart';
import '../constants/fetch.dart';
import 'category_dialog.dart';

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
