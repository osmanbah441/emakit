import 'package:emakit/app_router.dart';
import 'package:component_library/component_library.dart';
import 'package:api/api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

const _debugging = bool.fromEnvironment('DEBUG', defaultValue: true);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (_debugging) {
    Api.useEmulator(
      db: ('localhost', 9399),
      auth: ('localhost', 9099),
      fn: ('localhost', 5001),
      firestore: ('localhost', 8080),
      storage: ('localhost', 9199),
    );
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      theme: AppThemeData.light(context),
      darkTheme: AppThemeData.dark(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.router,
      title: 'Salone Bazaar',
    );
  }
}
