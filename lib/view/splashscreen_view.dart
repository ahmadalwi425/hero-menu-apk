import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatelessWidget  {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: new AssetImage("assets/images/splash_screen.png"),
            fit: BoxFit.cover,
          ),
        ),
//        child: center,
      ),
    );
  }
}
