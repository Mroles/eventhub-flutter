import 'package:eventhub/globals.dart';
import 'package:flutter/material.dart';
import '../utils/functions.dart';

Widget Textbox(BuildContext context, String labeltext,
    TextEditingController textEditingController, Widget widget) {
  Size size = MediaQuery.of(context).size;
  return Container(
    //padding: const EdgeInsets.symmetric(horizontal: 20),
    width: size.width * 0.95,
    decoration: BoxDecoration(
      color: (tertiaryColorLight),
      borderRadius: BorderRadius.circular(29),
    ),

    child: TextFormField(
      autocorrect: false,
      obscureText: labeltext.toLowerCase() == "password" ||
              labeltext.toLowerCase() == 'confirm password'
          ? true
          : false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15.0),
          border: InputBorder.none,
          iconColor: secondaryColorLight,
          hintStyle: TextStyle(color: secondaryColorLight),
          prefixIcon: widget,
          prefixIconColor: secondaryColorLight,
          labelText: labeltext,
          labelStyle: const TextStyle(color: secondaryColorLight)),
      controller: textEditingController,
    ),
  );
}

Widget TextboxNoIcon(BuildContext context, String labeltext,
    TextEditingController textEditingController) {
  Size size = MediaQuery.of(context).size;
  return Container(
    //padding: const EdgeInsets.symmetric(horizontal: 20),
    width: size.width * 0.95,
    decoration: BoxDecoration(
      color: (tertiaryColorLight),
      borderRadius: BorderRadius.circular(29),
    ),

    child: TextFormField(
      autocorrect: false,
      obscureText: labeltext.toLowerCase() == "password" ||
              labeltext.toLowerCase() == 'confirm password'
          ? true
          : false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15.0),
          border: InputBorder.none,
          iconColor: secondaryColorLight,
          hintStyle: TextStyle(color: secondaryColorLight),
          prefixIconColor: secondaryColorLight,
          labelText: labeltext,
          labelStyle: const TextStyle(color: secondaryColorLight)),
      controller: textEditingController,
    ),
  );
}

Widget LargeButton(
    BuildContext context, bool _isLoading, String buttonText, Widget widget) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width * 0.95,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              elevation: 0,
              backgroundColor: secondaryColorLight),
          onPressed: () {
            navigateToPage(0, context, widget);
          },
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          )),
    ),
  );
}

Widget TextTap(BuildContext context, String text, Widget widget) {
  return GestureDetector(
    child: Text(
      text,
      style: const TextStyle(color: secondaryColorLight),
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
  return Container(
    decoration: BoxDecoration(
      color: (tertiaryColorLight),
      borderRadius: BorderRadius.circular(29),
    ),
    child: TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15.0),
          border: InputBorder.none,
          iconColor: secondaryColorLight,
          hintStyle: const TextStyle(
            color: secondaryColorLight,
          ),
          prefixIconColor: secondaryColorLight,
          labelText: text,
          labelStyle: const TextStyle(color: secondaryColorLight)),
    ),
  );
}

Widget sizedBox(double height) {
  return SizedBox(height: height);
}

Widget loader(double scale) {
  return Transform.scale(
    scale: scale,
    child: const CircularProgressIndicator(
      color: Colors.black,
    ),
  );
}
