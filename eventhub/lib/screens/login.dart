import 'package:eventhub/main.dart';
import 'package:eventhub/screens/forgotpassword.dart';
import 'package:eventhub/screens/signup.dart';
import 'package:eventhub/utils/accountcalls.dart';
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
  @override
  Widget build(BuildContext context) {
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
            child: Form(
              key: formKey,
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
                    TextTap(context, "Forgot Password", ForgotPassword())
                  ]),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            )
                          : const Text("Login"),
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        await logUserIn(_emailController.text,
                                    _passwordController.text) ==
                                200
                            ? navigateToPage(
                                0, context, const MyHomePage(title: "Home"))
                            : await logUserIn(_emailController.text,
                                        _passwordController.text) ==
                                    401
                                ? snacc(context, "Wrong Username or Password")
                                : snacc(context, "An Error Occured");
                        setState(() {
                          _isLoading = false;
                        });
                      }),
                  const SizedBox(height: 20.0),
                  TextTap(context, "Don't Have an Account? Sign Up", SignUp())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
