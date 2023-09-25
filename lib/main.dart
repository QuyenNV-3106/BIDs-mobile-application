import 'package:bid_online_app_v2/pages/splash/splash_screen.dart';
import 'package:bid_online_app_v2/routes.dart';
import 'package:bid_online_app_v2/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: const HomePage(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
