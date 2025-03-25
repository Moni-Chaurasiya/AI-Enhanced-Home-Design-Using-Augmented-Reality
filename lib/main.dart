/*import 'package:visionaryhome/providers/shopping_cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:visionaryhome/Login_screen.dart';

import 'package:visionaryhome/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

//import 'package:arkit_plugin/arkit_plugin.dart';

//import 'package:vector_math/vector_math_64.dart' as vector;

bool shouldUseFirestoreEmulator = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    // User is already signed in
  }
  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CartProvider();
      },
      child: MaterialApp(
        title: 'Visionary Home',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirebaseAuth.instance.currentUser != null
            ? const HomeScreen()
            : LoginScreen(),
      ),
    );
  }
}
*/

import 'package:visionaryhome/providers/shopping_cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:visionaryhome/Login_screen.dart';

import 'package:visionaryhome/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

//import 'package:arkit_plugin/arkit_plugin.dart';

//import 'package:vector_math/vector_math_64.dart' as vector;

bool shouldUseFirestoreEmulator = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (FirebaseAuth.instance.currentUser != null) {
    // User is already signed in
  }
  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return CartProvider();
      },
      child: MaterialApp(
        title: 'Visionary Home',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 1, 34, 84),
          scaffoldBackgroundColor:
              Colors.white, // Optional: Set background color
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 1, 34, 84),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 1, 34, 84),
            primary: const Color.fromARGB(255, 1, 34, 84),
            secondary: Colors.blueGrey,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FirebaseAuth.instance.currentUser != null
              ? const HomeScreen()
              : LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 34, 84),
      body: Center(
        child:
            Image.asset('assets/Home/logo.png'), // Replace with your logo asset
      ),
    );
  }
}


/*
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _logoOpacity = 0;
  double _appNameOpacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _logoOpacity = 1;
      });
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _appNameOpacity = 1;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FirebaseAuth.instance.currentUser != null
              ? const HomeScreen()
              : LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 34, 84),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _logoOpacity,
              duration: const Duration(milliseconds: 500),
              child: Image.asset('assets/Home/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}


*/






/*
class CameraDistancePage extends StatefulWidget {
  const CameraDistancePage({super.key});

  @override
  _CameraDistancePageState createState() => _CameraDistancePageState();
}

class _CameraDistancePageState extends State<CameraDistancePage> {
  ARKitController? arkitController;
  vector.Vector3? lastPosition;
  String distance = '0';

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Camera Distance'),
      ),
      body: Stack(
        children: [
          ARKitSceneView(
            enableTapRecognizer: true,
            onARKitViewCreated: onARKitViewCreated,
            showFeaturePoints: true,
            showWorldOrigin: true,
            worldAlignment: ARWorldAlignment.camera,
          ),
          Text(distance, style: Theme.of(context).textTheme.headline4),
        ],
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController?.onARTap = (ar) {
      final point =
          ar.firstWhere((o) => o.type == ARKitHitTestResultType.featurePoint);
      final position = vector.Vector3(
        point.worldTransform.getColumn(3).x,
        point.worldTransform.getColumn(3).y,
        point.worldTransform.getColumn(3).z,
      );
      setState(() {
        distance =
            _calculateDistanceBetweenPoints(vector.Vector3.zero(), position);
      });
        };
  }

  String _calculateDistanceBetweenPoints(vector.Vector3 A, vector.Vector3 B) {
    final length = A.distanceTo(B);
    return '${(length * 100).toStringAsFixed(2)} cm';
  }
}
*/