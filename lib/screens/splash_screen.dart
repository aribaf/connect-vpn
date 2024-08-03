import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), (){
      
      //exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      
    //navigate home
    Get.off(()=> HomeScreen());

      //Navigator.pushReplacement(
       // context, MaterialPageRoute( builder: (_) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {

    //initializing media query for getting device screen size
mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children:
        //app logo
         [Positioned(
          left: mq.width * .3,
          top: mq.width * .9,
          width: mq.width * .4,
          child: Image.asset('assets/images/secure.png')),

        
          Positioned(
            bottom: mq.height * .15,
            width: mq.width,

            child: Text(
              'Stay Secure, Stay Connected.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).lightText,
              ),
              ))
        ],
      ),
    );
  }
}