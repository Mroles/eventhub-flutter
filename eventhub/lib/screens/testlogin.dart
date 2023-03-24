import 'package:eventhub/globals.dart';
import 'package:eventhub/main.dart';
import 'package:eventhub/screens/forgotpassword.dart';
import 'package:eventhub/screens/signup.dart';
import 'package:eventhub/utils/accountcalls.dart';
import 'package:eventhub/widgets/background.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/functions.dart';
import '../providers/loginprovider.dart';

class TestLogin extends StatefulWidget {
  @override
  State<TestLogin> createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginProv = Provider.of<LoginLoadProvider>(context);

    return Scaffold(
      body: Background(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("LOGIN"),
              Container(
                decoration: BoxDecoration(color: tertiaryColorLight),
              ),
              SizedBox(height: size.width * 0.04),
              Textbox(context, "Email or Username", _emailController,
                  const Icon(Icons.person)),
              SizedBox(height: size.width * 0.04),
              Textbox(context, "Password", _passwordController,
                  const Icon(Icons.lock)),
              SizedBox(height: size.width * 0.04),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child:
                        TextTap(context, "Forgot Password", ForgotPassword()))
              ]),
              SizedBox(height: size.width * 0.04),
              Container(
                width: size.width * 0.95,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          elevation: 0,
                          backgroundColor: secondaryColorLight),
                      child: loginProv.isLoading
                          ? SizedBox(
                              height: size.height * 0.03,
                              child: const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text("LOGIN"),
                      onPressed: () => context
                          .read<LoginLoadProvider>()
                          .logIn("Selorm", "Abofra")),
                ),
              ),
              const SizedBox(height: 20.0),
              TextTap(context, "Don't Have an Account? Sign Up", SignUp())
            ],
          ),
        ),
      ),
    );
  }
}
