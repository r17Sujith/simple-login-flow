import 'package:flutter/material.dart';
import 'package:wingman/screens/home_screen.dart';
import 'package:wingman/screens/login_screen.dart';
import 'package:wingman/utils/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: sharedPrefs.token!=null?const HomeScreen():const LoginScreen(),
    );
  }
}
