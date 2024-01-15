import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qibla_finder_app/screens/prayer_times_screen.dart';
import 'package:qibla_finder_app/screens/qibla_screen.dart';

import '../widgets/linear_color.dart';

class PermissionScreen extends StatefulWidget {
   PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool hasPermission = false;

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  Future<void> getPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      bool serviceStatus = await Geolocator.openLocationSettings();
      if (!serviceStatus) {
        print('User did not enable location services');
        return;
      }
    }

    var status = await Permission.location.status;

    // Check if a permission request is already in progress
    if (status == PermissionStatus.denied) {
      try {
        await Permission.location.request();
        // Permission request successful
        setState(() {
          hasPermission = true;
        });
      } catch (e) {
        // Permission request failed
        print('Permission request failed: $e');
      }
    } else {
      // Permission is already granted or denied
      setState(() {
        hasPermission = (status == PermissionStatus.granted);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Container(
        decoration: buildContainerDecoration(),
        child: Column(
          children: [
            SizedBox(
              height: 320,
              child: Stack(
                children: [
                  Positioned(
                    left: 80,
                    right: 80,
                    child: Image.asset(
                      "assets/images/Group.png",
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/Objects.png",
                    ),
                  ),
                ],
              ),
            ),
            Text("Qibla Finder",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("For best possible experience, the app will require a set of\npermissions. Please grant them in order to achieve\nbest possible experience.",
              style: TextStyle(fontSize: 11),),
            ),
            Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("The permissions include:\n"
              "• Access to read phone state (To stop audio playback\n"
              "during a call event)\n"
              "• Access to read and write external storage (To download aya audios for playback)\n"
              "• Access to location (To find location and QIbla direction)",
            style: TextStyle(fontSize: 11),),
        ),
            SizedBox(
              height: 80,
            ),
            SizedBox(
              width: 230,
              height: 51,
              child:
              FutureBuilder(
                future: getPermission(),
                builder: (context, snapshot) {
                  return ElevatedButton(
                      onPressed: (){
                  if(hasPermission){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        PrayerTimesScreen()));
                  }
                  },
                      style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff503112),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                  )
                  ,child: Text("Continue",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        color: Colors.white
                      ),));
                }
              ),
            ),
          ],
        ),
      )

    );

  }
}
