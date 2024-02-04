import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/screens/splashScreen.dart';
import 'package:get/get.dart';
import 'helpers/pref.dart';

//gobal object for accessing device screen size
late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // enter full screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  // await Firebase.initializeApp();

  await Pref.initializeHive();

  await AdHelper.intitads();

  // for setting orientation to protrait only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (v) {
      runApp(const MyApp());
    },
  );
}

class Firebase {
  static initializeApp() {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vpn X',
      home: SplashScreen(),
      // theme
      theme: ThemeData(
          appBarTheme: AppBarTheme(centerTitle: true, elevation: 10),
          primaryColor: Colors.cyan.shade500),

      // theme mode
      themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 10),
      ),
    );
  }
}

// theme data
extension AppTheme on ThemeData {
  Color get lightText => Pref.isDarkMode ? Colors.white70 : Colors.black54;
  Color get bottonNav => Pref.isDarkMode ? Colors.white12 : Colors.cyan;
}
