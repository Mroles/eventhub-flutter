import 'package:eventhub/main.dart';
import 'package:eventhub/screens/login.dart';
import 'package:eventhub/widgets/background.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SIGN UP"),
              SizedBox(height: size.width * 0.04),
              Textbox(context, "Username", _usernameController,
                  const Icon(Icons.mail)),
              SizedBox(height: size.width * 0.04),
              Textbox(
                  context, "Email", _emailController, const Icon(Icons.mail)),
              SizedBox(height: size.width * 0.04),
              Textbox(context, "Full Name", _fullNameController,
                  const Icon(Icons.person)),
              SizedBox(height: size.width * 0.04),
              Textbox(context, "Password", _passwordController,
                  const Icon(Icons.key)),
              SizedBox(height: size.width * 0.04),
              Textbox(context, "Confirm Password", _confirmPasswordController,
                  const Icon(Icons.key)),
              SizedBox(height: size.width * 0.04),
              LargeButton(context, _isLoading, "SIGN UP",
                  const MyHomePage(title: "Home")),
              const SizedBox(height: 20.0),
              TextTap(context, "Already Have an Account? Log In ", Login())
            ],
          ),
        ),
      ),
    );
  }
}
