import 'package:eventhub/globals.dart';
import 'package:eventhub/main.dart';
import 'package:eventhub/screens/forgotpassword.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            )
                          : const Text("LOGIN"),
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() {
                                _isLoading = true;
                              });

                              await logUserIn(_emailController.text,
                                          _passwordController.text) ==
                                      200
                                  ? navigateToPage(0, context,
                                      const MyHomePage(title: "Home"))
                                  : await logUserIn(_emailController.text,
                                              _passwordController.text) ==
                                          401
                                      ? snacc(
                                          context, "Wrong Username or Password")
                                      : snacc(context, "An Error Occured");
                              setState(() {
                                _isLoading = false;
                              });
                            }),
                ),
              ),
              const SizedBox(height: 20.0),

              // GestureDetector(
              //   child: const Text("Don't Have an Account? Sign Up"),
              //   onTap: () {
              //     setState(() {
              //       _switch = !_switch;
              //     });
              //   },
              // ),

              // PageTransitionSwitcher(
              //     transitionBuilder:
              //         (child, primaryAnimation, secondaryAnimation) {
              //       return SharedAxisTransition(
              //         animation: primaryAnimation,
              //         secondaryAnimation: secondaryAnimation,
              //         child: child,
              //         transitionType: SharedAxisTransitionType.horizontal,
              //       );
              //     },
              //     child: _switch ? SignUp() : Text("data"))

              TextTap(context, "Don't Have an Account? Sign Up", SignUp())
            ],
          ),
        ),
      ),
    );
  }
}
