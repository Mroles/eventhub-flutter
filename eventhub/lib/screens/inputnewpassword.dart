import 'package:eventhub/screens/login.dart';
import 'package:eventhub/widgets/background.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
              const Text("RESET PASSWORD"),
              const SizedBox(
                height: 40.0,
              ),
              Textbox(context, "Email", _oldPasswordController,
                  const Icon(Icons.mail)),
              const SizedBox(height: 40.0),
              Textbox(context, "Email", _newPasswordController,
                  const Icon(Icons.mail)),
              Textbox(context, "Email", _confirmPasswordController,
                  const Icon(Icons.mail)),
              LargeButton(context, _isLoading, "CHANGE PASSWORD",
                  const MyHomePage(title: "Home")),
              const SizedBox(
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
