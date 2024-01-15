import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qibla_finder_app/screens/duas/duas_screen.dart';
import 'package:qibla_finder_app/screens/feedback_screen.dart';
import 'package:qibla_finder_app/screens/more_options_screen.dart';
import 'package:qibla_finder_app/screens/names_of_allah_screen.dart';
import 'package:qibla_finder_app/screens/permission_screen.dart';
import 'package:qibla_finder_app/screens/prayer_times_screen.dart';
import 'package:qibla_finder_app/screens/qibla_screen.dart';
import 'package:qibla_finder_app/screens/splash_screen.dart';
import 'package:qibla_finder_app/screens/quran_screen.dart';
import 'package:qibla_finder_app/screens/tasbih_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  runApp( AppRoot());
}
class AppRoot extends StatefulWidget {
   AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: SplashScreen()
    );
  }
}