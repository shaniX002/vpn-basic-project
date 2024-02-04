import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      // navigate to home
      Get.off(() => HomeScreen());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query(for getting device screen size)
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //App Logo
          Positioned(
              left: mq.width * .1,
              width: mq.width * .8,
              top: mq.height * .25,
              child: Image.asset('assets/images/logo.png')),
          //Label Text
          Positioned(
              bottom: mq.height * .15,
              width: mq.width,
              child: Text(
                'MADE BY SHANI X FLUTTER 💙',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
