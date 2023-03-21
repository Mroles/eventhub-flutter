import 'package:eventhub/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          Text("Login"),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(
                "assets/wave-top.svg",
                width: size.width,
                color: secondaryColorLight,
              )),
          Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(
                "assets/wave.svg",
                width: size.width,
                color: secondaryColorLight,
              )),
          child,
        ],
      ),
    );
  }
}
