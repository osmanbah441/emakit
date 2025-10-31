import 'package:flutter/material.dart';
import 'package:product_list/product_list.dart';
import 'package:product_variation/product_variation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:component_library/component_library.dart';
import 'package:product_repository/product_repository.dart';
import 'package:domain_models/domain_models.dart';

const _supabaseUrl = String.fromEnvironment(
  'SUPABASE_URL',
  defaultValue: 'http://127.0.0.1:54321',
);
const _supabaseAnonKey = String.fromEnvironment(
  'SUPABASE_ANON_KEY',
  defaultValue: 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: _supabaseUrl, anonKey: _supabaseAnonKey);
  runApp(const MyApp());
}

// -----------------------------------------------------------------
// 1. Main Application Setup
// -----------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seller Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.light(context),
      darkTheme: AppThemeData.dark(context),
      home: const SellerAppHome(),
    );
  }
}

// -----------------------------------------------------------------
// 2. Stateful Widget to Manage Navigation State
// -----------------------------------------------------------------
class SellerAppHome extends StatefulWidget {
  const SellerAppHome({super.key});

  @override
  State<SellerAppHome> createState() => _SellerAppHomeState();
}

class _SellerAppHomeState extends State<SellerAppHome> {
  int _selectedIndex = 0; // The currently selected tab index

  final productRepository = ProductRepositoryImpl(role: ApplicationRole.store);

  // List of all the screens in the bottom navigation
  List<Widget> _screens() => [
    HomeScreen(),
    StoreProductListScreen(
      productRepository: productRepository,
      onAddProduct: () {},
      onProductTap: (id) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductVariationListScreen(
              onProductTap: () {},
              productRepository: productRepository,
              productId: id,
              onAddVariation: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductVariationAddScreen(
                      productId: id,
                      productRepository: productRepository,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    ),
    OrdersScreen(),
    ProfileScreen(),
  ];

  // Handler for when a bottom navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Define the main content and navigation structure
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens().elementAt(
          _selectedIndex,
        ), // Display the selected screen
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex:
            _selectedIndex, // The index of the currently selected item
        selectedItemColor: Colors.deepPurple[800],
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        onTap: _onItemTapped, // Call handler when an item is tapped
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

// -----------------------------------------------------------------
// 3. Placeholder Screen Widgets
// -----------------------------------------------------------------

// Home Screen Placeholder
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 80, color: Colors.deepPurple),
          SizedBox(height: 20),
          Text(
            'Home Dashboard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            'Summary of sales and key metrics.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// Orders Screen Placeholder
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 80, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Customer Orders',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            'View new and pending orders.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// Profile Screen Placeholder
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Colors.orange),
          SizedBox(height: 20),
          Text(
            'Seller Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Text(
            'Manage account settings and details.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
