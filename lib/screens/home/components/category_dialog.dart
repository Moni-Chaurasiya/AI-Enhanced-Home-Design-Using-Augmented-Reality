/*import 'package:flutter/material.dart';
import '../../../models/product_model.dart';

class CategoryDialog extends StatelessWidget {
  final List<ProductModel> products;
  final ValueChanged<String> onCategorySelected;

  const CategoryDialog({
    Key? key,
    required this.products,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract unique category names
    final categories = products.map((p) => p.category).toSet().toList();
    categories.sort(); // optional: sort them

    return Dialog(
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Select a Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final categoryName = categories[index];
                  return ListTile(
                    title: Text(categoryName),
                    onTap: () {
                      onCategorySelected(categoryName);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/