import 'package:final_project/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondSplashScreenView extends StatefulWidget {
  const SecondSplashScreenView({Key? key}) : super(key: key);

  @override
  _SecondSplashScreenViewState createState() => _SecondSplashScreenViewState();
}

class _SecondSplashScreenViewState extends State<SecondSplashScreenView> {


  @override
  Widget build(BuildContext context) {
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

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeView()),(Route<dynamic> route) => false);
    });
  }
}
