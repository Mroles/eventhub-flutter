import 'package:eventhub/main.dart';
import 'package:eventhub/screens/login.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/loginprovider.dart';

class SignUp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _isLoading = context.watch<LoadingProvider>().isLoading;

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
            Color.fromARGB(255, 87, 44, 194),
            Color.fromARGB(255, 56, 145, 213)
          ])),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Textbox(context, "Username", _usernameController,
                    const Icon(Icons.mail)),
                const SizedBox(height: 40.0),
                Textbox(
                    context, "Email", _emailController, const Icon(Icons.mail)),
                const SizedBox(height: 40.0),
                Textbox(context, "Full Name", _fullNameController,
                    const Icon(Icons.person)),
                const SizedBox(height: 40.0),
                Textbox(context, "Password", _passwordController,
                    const Icon(Icons.key)),
                const SizedBox(height: 40.0),
                Textbox(context, "Confirm Password", _confirmPasswordController,
                    const Icon(Icons.key)),
                const SizedBox(height: 40.0),
                LargeButton(context, _isLoading, "Sign Up",
                    const MyHomePage(title: "Home")),
                TextTap(context, "Already Have an Account? Log In ", Login())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
