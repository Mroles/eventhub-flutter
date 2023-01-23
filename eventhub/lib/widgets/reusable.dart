import 'package:eventhub/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/loginprovider.dart';
import '../utils/functions.dart';

Widget Textbox(BuildContext context, String labeltext,
    TextEditingController textEditingController, Widget widget) {
  return Container(
    child: TextFormField(
      autocorrect: false,
      obscureText: labeltext.toLowerCase() == "password" ||
              labeltext.toLowerCase() == 'confirm password'
          ? true
          : false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: widget,
          labelText: labeltext,
          labelStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
      controller: textEditingController,
    ),
  );
}

Widget TextboxNoIcon(BuildContext context, String labeltext,
    TextEditingController textEditingController) {
  return Container(
    child: TextFormField(
      autocorrect: false,
      obscureText: labeltext.toLowerCase() == "password" ||
              labeltext.toLowerCase() == 'confirm password'
          ? true
          : false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labeltext,
          labelStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
      controller: textEditingController,
    ),
  );
}

Widget LargeButton(
    BuildContext context, bool _isLoading, String buttonText, Widget widget) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
      child: _isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            )
          : Text(buttonText),
      onPressed: () => {
            _isLoading ? null : context.read<LoadingProvider>().change(),
            navigateToPage(0, context, widget),
            context.read<LoadingProvider>().change()
          });
}

Widget TextTap(BuildContext context, String text, Widget widget) {
  return GestureDetector(
    child: Text(
      text,
      style: const TextStyle(color: Color.fromARGB(255, 206, 22, 9)),
    ),
    onTap: () => text.toLowerCase() == "forgot password"
        ? navigateToPageLite(0, context, widget, null)
        : navigateToPage(0, context, widget),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snacc(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(text)));
}

Widget textArea(
    BuildContext context, String text, TextEditingController controller) {
  return TextField(
    keyboardType: TextInputType.multiline,
    maxLines: null,
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: text,
        labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
  );
}

Widget sizedBox(double height) {
  return SizedBox(height: height);
}
