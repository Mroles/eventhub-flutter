import 'package:animations/animations.dart';
import 'package:eventhub/main.dart';
import 'package:eventhub/screens/forgotpassword.dart';
import 'package:eventhub/screens/post.dart';
import 'package:eventhub/screens/signup.dart';
import 'package:eventhub/utils/accountcalls.dart';
import 'package:eventhub/widgets/background.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import '../utils/functions.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _switch = false;

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text("Welcome", style: TextStyle(fontSize: 32)),
      ],
    ));
  }
}
