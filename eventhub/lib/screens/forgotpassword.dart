import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
            Color.fromARGB(255, 87, 44, 194),
            Color.fromARGB(255, 56, 145, 213)
          ])),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                Textbox(
                    context, "Email", _emailcontroller, const Icon(Icons.mail)),
                const SizedBox(height: 40.0),
                LargeButton(context, _isLoading, "Send Reset Link",
                    const MyHomePage(title: "Home")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
