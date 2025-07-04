import 'package:add_edit_product/add_edit_product.dart';
import 'package:cart/cart.dart';
import 'package:checkout/checkout.dart';
import 'package:domain_models/domain_models.dart';
import 'package:filter/filter.dart';

import 'package:component_library/component_library.dart';
import 'package:dataconnect/dataconnect.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:functions/functions.dart';
import 'package:manage_categories/manage_categories.dart';
import 'package:product_details/product_details.dart';
import 'package:product_list/product_list.dart';
import 'package:profile/profile.dart';

import 'firebase_options.dart';

const _debugging = bool.fromEnvironment('DEBUG', defaultValue: true);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (_debugging) {
    DataconnectService.useEmulator('localhost', 9399);
    MooemartFunctions.useEmulator('localhost', 5001);
  }
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.light(context),
      darkTheme: AppThemeData.dark(context),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Emakit',
      home: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actionsPadding: const EdgeInsets.only(right: 12),
      //   title: const Text('Emakit'),
      //   actions: [
      //     CartIconButton(
      //       itemCount: 10,
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => CartScreen(
      //               onCheckoutTap: (context) => Navigator.push(
      //                 context,
      //                 MaterialPageRoute(builder: (context) => CheckoutScreen()),
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     ),

      //     IconButton(
      //       onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => ProfileScreen()),
      //       ),
      //       icon: const Icon(Icons.person),
      //     ),
      //   ],
      // ),
      body: ProductListScreen(
        filterDialog: CategorySelectionAlertDialog(),
        onAddNewProductTap: (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddEditProductScreen()),
        ),

        onManageCategoryTap: (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ManageCategoryScreen()),
        ),

        onCategoryFilterTap: (category) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FilterScreen(id: category.id!, mainCategoryName: category.name),
          ),
        ),
        onProductTap: (context, productId) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(productId: productId),
          ),
        ),
      ),
    );
  }
}
