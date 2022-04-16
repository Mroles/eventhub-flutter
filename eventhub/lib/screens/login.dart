import 'package:eventhub/main.dart';
import 'package:eventhub/screens/signup.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/loginprovider.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _isLoading = context.watch<LoadingProvider>().isLoading;

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
                const SizedBox(height: 40.0),
                Textbox(context, "Email or Username", _emailController,
                    const Icon(Icons.person)),
                const SizedBox(height: 40.0),
                Textbox(context, "Password", _passwordController,
                    const Icon(Icons.key)),
                const SizedBox(height: 20.0),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextTap(context, "Forgot Password",
                      const MyHomePage(title: "Home"))
                ]),
                const SizedBox(height: 40.0),
                LargeButton(context, _isLoading, "Login",
                    const MyHomePage(title: "Home")),
                const SizedBox(height: 20.0),
                TextTap(context, "Don't Have an Account? Sign Up", SignUp())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
