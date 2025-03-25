import 'package:flutter/material.dart';
//import 'package:visionaryhome/screens/home/components/designHome.dart';
import '../../../data/fetch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:visionaryhome/Login_screen.dart';
import 'package:visionaryhome/cart.dart';
import 'package:visionaryhome/newfav.dart';
import 'package:visionaryhome/Mes2.dart';
import '../orders/orders.dart';
import 'components/categories.dart';
import 'components/products.dart';
import 'components/search_bar.dart';
import 'components/products_placeholder.dart';
import 'components/interior.dart';
import 'components/measurement.dart';
import 'components/mood.dart';
import 'components/wall.dart';
import 'components/design.dart';
import 'components/ReDesignHome.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedCategoryIndex = 0;

  void onCategorySelected(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  // Build the category widgets to be displayed
  Widget _getSelectedCategoryWidget() {
    String selectedCategory = categoryList[selectedCategoryIndex];
    switch (selectedCategory) {
      case 'Furniture':
        return const Products();
      case 'Interiors':
        return const InteriorHomePage();
      case 'Moods':
        return const MoodHomePage();
      case 'Creators':
        return const WallHomePage();
      case 'Measurement':
        return const MeasurementHomePage();
      case 'Designs':
        return const InteriorDesignPage();
      case 'ReDesign':
        return const ReDesignHome();
      default:
        return ProductsPlaceholder(category: selectedCategory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'Visionary Home',
            style: TextStyle(
                color: Color.fromARGB(255, 1, 34, 84),
                fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 1, 34, 84)),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        drawer: const NavigationDrawer(),
        backgroundColor: Colors.white,
        body: SafeArea(
          // Use SafeArea
          child: Column(
            children: [
              // Padding applied to SearchBar directly for consistency
              const SearchBar(),
              Categories(
                selectedIndex: selectedCategoryIndex,
                onCategorySelected: onCategorySelected,
              ),
              Expanded(
                child: _getSelectedCategoryWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show warning if exit
  Future<bool?> showWarning(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to exit the app?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("NO"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("YES"),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser?.email ?? 'Not logged in';
    String? name = FirebaseAuth.instance.currentUser?.displayName ?? 'Customer';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email, style: const TextStyle(fontSize: 17)),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 8, 99, 244),
              child: Icon(Icons.person, color: Color.fromARGB(255, 1, 34, 84)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProductPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Orders()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.compare_arrows),
            title: const Text('Area Measurement'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const Mes(value: "assets/s14/chair.gltf")),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              // Navigate to help screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                //print('signout');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
