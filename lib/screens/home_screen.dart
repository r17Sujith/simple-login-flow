import 'package:flutter/material.dart';
import 'package:wingman/screens/login_screen.dart';
import 'package:wingman/utils/shared_preference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog
        bool confirmExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmation'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );

        // If user confirms, close the app
        if (confirmExit == true) {
          return true;
        }

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 100),
                color: Colors.blue,
                child: const Text("Log out\nTo remove token",style: TextStyle(fontSize: 25),),
              ),
               const Expanded(child: SizedBox(height: 10,)),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ElevatedButton(onPressed: () {
                   sharedPrefs.removeKey(sharedPrefs.keyToken);
                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                       builder: (context) =>   const LoginScreen()),(route) => false,);
                 },
                   child: const Text("Log out"),),
               )
            ],
          ),
        ),
        body: Stack(
          children: [
            ClipPath(
              clipper: BackgroundClipper(),
              child: Container(
                color: Colors.blue,
              ),
            ),
            const Center(
              child: Text(
                'Welcome to Home Screen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
