import 'package:eventhub/screens/login.dart';
import 'package:eventhub/screens/post.dart';
import 'package:flutter/material.dart';
import '../utils/functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() async {
    super.initState();

    await checkLogin()
        ? navigateToPage(1500, context, PostPage())
        : navigateToPage(1500, context, Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
