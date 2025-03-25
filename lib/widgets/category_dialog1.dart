import 'package:flutter/material.dart';
import '../constants/fetch.dart';

class CategoryDialog extends StatelessWidget {
  final Function(List<Item>) onCategorySelected;

  const CategoryDialog({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<Item>>(
          future: fetchItems(), // Fetch items dynamically
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No categories available');
            }

            final allItems = snapshot.data!;
            final uniqueCategories =
                allItems.map((item) => item.category).toSet().toList();

            return Column(
              children: [
                const Text(
                  'Select a Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: uniqueCategories.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final category = uniqueCategories[index];
                      return ListTile(
                        leading:
                            const Icon(Icons.category), // Use a generic icon
                        title: Text(category),
                        onTap: () {
                          final filteredItems = allItems
                              .where((item) => item.category == category)
                              .toList();
                          onCategorySelected(
                              filteredItems); // Pass filtered items
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
