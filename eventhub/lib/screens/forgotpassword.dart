import 'package:eventhub/screens/login.dart';
import 'package:eventhub/widgets/background.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("RESET PASSWORD"),
              const SizedBox(
                height: 40.0,
              ),
              Textbox(context, "Email", _newPasswordController,
                  const Icon(Icons.mail)),
              const SizedBox(height: 40.0),
              LargeButton(context, _isLoading, "Send Reset Link",
                  const MyHomePage(title: "Home")),
              SizedBox(
                height: 20.0,
              ),
              TextTap(context, "Back to Login", Login())
            ],
          ),
        ),
      ),
    );
  }
}
