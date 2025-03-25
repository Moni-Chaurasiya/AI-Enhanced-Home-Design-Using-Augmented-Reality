/*
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../constants/data.dart';

class CategoryDialog extends StatelessWidget {
  final Function(List<DetailModel>) onCategorySelected;

  const CategoryDialog({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width *
                          0.1), // 10% padding on each side
                  child: const Divider(), // The actual divider
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ListTile(
                    leading: Image.asset(category.icon, width: 40, height: 40),
                    title: Text(category.name),
                    onTap: () {
                      // Pass the selected category's products (DetailModel list)
                      onCategorySelected(category.products);
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
import 'package:flutter/material.dart';
import '../constants/fetch.dart';

class CategoryDialog extends StatefulWidget {
  final Function(List<Item>) onCategorySelected;

  const CategoryDialog({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  late Future<List<Item>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = fetchItems(); // Fetch items from API
  }

  @override
  Widget build(BuildContext context) {
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
              child: FutureBuilder<List<Item>>(
                future: _itemsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No categories available'));
                  }

                  List<Item> items = snapshot.data!;
                  Map<String, List<Item>> categoryMap = {};

                  for (var item in items) {
                    categoryMap.putIfAbsent(item.category, () => []).add(item);
                  }

                  return ListView.separated(
                    itemCount: categoryMap.keys.length,
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: const Divider(),
                    ),
                    itemBuilder: (context, index) {
                      String category = categoryMap.keys.elementAt(index);
                      List<Item> categoryItems = categoryMap[category]!;
                      return ListTile(
                        leading: categoryItems.isNotEmpty
                            ? Image.network(categoryItems[0].imgurl,
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image))
                            : const Icon(Icons.category),
                        title: Text(category),
                        onTap: () {
                          widget.onCategorySelected(categoryItems);
                          Navigator.pop(context);
                        },
                      );
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
