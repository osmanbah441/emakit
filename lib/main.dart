import 'package:backend/backend.dart';
import 'package:cart/cart.dart';
import 'package:category_screen/category_screen.dart';
import 'package:checkout/checkout.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:home_screen/home_screen.dart';
import 'package:order_details/order_details.dart';
import 'package:product_details/product_details.dart';
import 'package:profile/profile.dart';
import 'firebase_options.dart';

const _debugging = bool.fromEnvironment('DEBUG', defaultValue: true);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (_debugging) {
    DataconnectService.useEmulator('localhost', 9399);
    CloudFunctionService.useEmulator('localhost', 5001);
  }
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  final _pages = <Widget>[
    HomeScreen(
      onProductTap: (context, productId) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(productId: productId),
        ),
      ),
    ),
    CategoryScreen(),
    CartScreen(
      onCheckoutTap: (context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckoutScreen()),
      ),
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_selectedIndex],
        // body: OrderDetailsScreen(),
        bottomNavigationBar: BottomNavBar(
          onDestinationSelected: _onDestinationSelected,
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}
