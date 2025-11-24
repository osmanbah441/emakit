import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:category_management/category_management.dart';
import 'package:product_add_or_edit/product_add_or_edit.dart';
import 'package:product_list/product_list.dart';
import 'package:product_repository/product_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:category_repository/category_repository.dart';

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
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sl-Baz Admin',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: AppThemeData.light(context),
      darkTheme: AppThemeData.dark(context),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  final _productRepository = ProductRepositoryImpl();
  final _categoryRepository = CategoryRepositoryImpl();

  List<Widget> _pages() => [
    DashboardPage(),
    AdminProductListScreen(
      productRepository: _productRepository,
      onAddProduct: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ProductAddOrEditScreen(
              productRepository: _productRepository,
              categoryRepository: _categoryRepository,
              onSaveSuccess: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      onEditProduct: (id) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ProductAddOrEditScreen(
              productRepository: _productRepository,
              categoryRepository: _categoryRepository,
              productIdToEdit: id,
              onSaveSuccess: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    ),
    CategoryManagementScreen(categoryRepository: _categoryRepository),
    StoresPage(),
    OrdersPage(),
    UsersPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedIndex = index);
            },
            extended: true,
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.admin_panel_settings, size: 32),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_bag_outlined),
                selectedIcon: Icon(Icons.shopping_bag),
                label: Text('Products'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.category_outlined),
                selectedIcon: Icon(Icons.category),
                label: Text('Categories & Attributes'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.store_outlined),
                selectedIcon: Icon(Icons.store),
                label: Text('Stores'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long),
                label: Text('Orders'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: Text('Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages()[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}

// ======= Pages =======

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '📊 Dashboard Overview',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class StoresPage extends StatefulWidget {
  const StoresPage({super.key});

  @override
  State<StoresPage> createState() => _StoresPageState();
}

class _StoresPageState extends State<StoresPage> {
  final List<Map<String, dynamic>> _stores = [
    {'name': 'TechHub', 'owner': 'Alice', 'approved': true},
    {'name': 'FashionFi', 'owner': 'Bob', 'approved': false},
    {'name': 'HomeSmart', 'owner': 'Carol', 'approved': true},
  ];

  void _toggleApproval(int index) {
    setState(() {
      _stores[index]['approved'] = !_stores[index]['approved'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🏪 Store Management',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: _stores.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final store = _stores[index];
                return ListTile(
                  leading: Icon(
                    store['approved']
                        ? Icons.check_circle
                        : Icons.cancel_outlined,
                    color: store['approved'] ? Colors.green : Colors.red,
                  ),
                  title: Text(store['name']),
                  subtitle: Text('Owner: ${store['owner']}'),
                  trailing: FilledButton.tonalIcon(
                    onPressed: () => _toggleApproval(index),
                    icon: Icon(
                      store['approved']
                          ? Icons.block
                          : Icons.check_circle_outline,
                    ),
                    label: Text(store['approved'] ? 'Disable' : 'Approve'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '📦 Orders Management',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '👥 User Management',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '⚙️ Settings',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }
}
