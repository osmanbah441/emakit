import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:salone_bazaar/router/app_router.dart';
import 'package:user_repository/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'firebase_options.dart';

const _debugging = bool.fromEnvironment('DEBUG', defaultValue: true);

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

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // if (_debugging) {
  //   UserRepository.useEmulator();
  // }

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
