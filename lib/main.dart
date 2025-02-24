import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';

import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/screens/splash_screen.dart';

//global object for accessing device screen size
late Size mq;
Future<void> main() async {

WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

await Pref.initializeHive();

await AdHelper.initAds();

SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((v){

});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Connect VPN',
      home: SplashScreen(),


    //theme
    theme: ThemeData(
      appBarTheme: AppBarTheme(centerTitle: true, elevation: 3)
    ),
    
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(centerTitle: true, elevation: 3) ),

      themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
   );
  }
}

extension AppTheme on ThemeData{

   Color get lightText => Pref.isDarkMode ? Colors.white : Colors.black;
   Color get bottomav => Pref.isDarkMode ? Colors.white10 : Colors.teal;

}
