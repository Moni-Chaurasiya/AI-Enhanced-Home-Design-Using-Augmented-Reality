import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/product_model.dart';
import '../../../data/fetch.dart'; // Ensure this fetches API data
import '../../details/details_screen.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: black.withOpacity(0.07),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onSubmitted: (String x) {
            print("oh");
          },
          onTap: () {
            showSearch(context: context, delegate: datasearch());
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(
                vertical: appPadding * 0.75,
                horizontal: appPadding,
              ),
              fillColor: white,
              hintText: 'Search',
              prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: datasearch());
                  })),
        ),
      ),
    );
  }
}

class datasearch extends SearchDelegate {
  late Future<List<ProductModel>> _productsFuture;

  datasearch() {
    _productsFuture = fetchProducts(); // Fetch products on search
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        List<ProductModel> filternames = snapshot.data!
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        if (filternames.isEmpty) {
          return Center(child: Text('No products found matching "$query".'));
        }

        return _buildListView(filternames);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<ProductModel> displayList = snapshot.data ?? [];

        return _buildListView(displayList);
      },
    );
  }

  Widget _buildListView(List<ProductModel> productList) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, i) {
        Size size = MediaQuery.of(context).size;
        ProductModel product = productList[i];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsScreen(
                  product: product,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(appPadding / 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      fit: BoxFit.cover,
                      height: size.height * 0.24,
                      width: double.infinity,
                      product.imageUrl,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    )),
                const SizedBox(height: 5),
                Text(
                  product.name,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: black,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'by ${product.manufacturer}',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: black.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
            onPressed: () {
              query = "";
              showSuggestions(context);
            },
            icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }
}




















/*
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/product_model.dart';
import '../../../data/fetch.dart';
import '../../details/details_screen.dart';
import 'category_dialog.dart'; // The new one above

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: black.withOpacity(0.07),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onSubmitted: (String x) {
            print("oh");
          },
          onTap: () {
            showSearch(context: context, delegate: datasearch());
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(
                vertical: appPadding * 0.75,
                horizontal: appPadding,
              ),
              fillColor: white,
              hintText: 'Search',
              prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(context: context, delegate: datasearch());
                  })),
        ),
      ),
    );
  }
}

class datasearch extends SearchDelegate {
  late Future<List<ProductModel>> _productsFuture;
  String? selectedCategory; // <-- New: track which category user selected

  datasearch() {
    _productsFuture = fetchProducts(); // Fetch products on search
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        // Start with all products
        List<ProductModel> filteredList = snapshot.data!;

        // 1) If user typed a query, filter by name
        if (query.isNotEmpty) {
          filteredList = filteredList
              .where((item) =>
                  item.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }

        // 2) If user picked a category, filter by that category
        if (selectedCategory != null) {
          filteredList = filteredList
              .where((item) => item.category == selectedCategory)
              .toList();
        }

        if (filteredList.isEmpty) {
          return Center(child: Text('No products found matching "$query".'));
        }

        return _buildListView(filteredList, context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // If still loading or we got no data, show an empty list
        if (!snapshot.hasData) {
          return const Center(child: SizedBox.shrink());
        }

        // Show suggestions (without typed query filtering)
        List<ProductModel> displayList = snapshot.data!;

        // If user picked a category, filter those suggestions
        if (selectedCategory != null) {
          displayList = displayList
              .where((item) => item.category == selectedCategory)
              .toList();
        }

        return _buildListView(displayList, context);
      },
    );
  }

  Widget _buildListView(List<ProductModel> productList, BuildContext context) {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, i) {
        Size size = MediaQuery.of(context).size;
        ProductModel product = productList[i];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailsScreen(
                  product: product,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(appPadding / 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      fit: BoxFit.cover,
                      height: size.height * 0.24,
                      width: double.infinity,
                      product.imageUrl,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    )),
                const SizedBox(height: 5),
                Text(
                  product.name,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: black,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'by ${product.manufacturer}',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: black.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // Clear text button (X)
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
            showSuggestions(context);
          },
          icon: const Icon(Icons.close),
        ),

      // Button to open Category Dialog
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () async {
          // First, load your products so the dialog can display available categories:
          final products = await _productsFuture;

          // Show the CategoryDialog
          final chosenCategory = await showDialog<String>(
            context: context,
            builder: (context) {
              return CategoryDialog(
                products: products,
                onCategorySelected: (selectedCat) {
                  // Return the category name
                  Navigator.pop(context, selectedCat);
                },
              );
            },
          );

          // If user picks a category, store it and show results
          if (chosenCategory != null) {
            selectedCategory = chosenCategory;
            // Optionally place the category name into the query for user feedback:
            query = chosenCategory;

            // Refresh the UI
            showResults(context);
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }
}
*/