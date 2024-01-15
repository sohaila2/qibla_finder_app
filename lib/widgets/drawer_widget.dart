import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../screens/feedback_screen.dart';
import 'linear_color.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 242,
      child: Container(
        decoration: buildContainerDecoration(),

        child: Padding(
          padding: const EdgeInsets.only(top: 60,left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 240,
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
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/Objects.png",
                      ),
                    ),
                  ],
                ),
              ),
              Text("Qibla Finder"),
              SizedBox(
                height: 32,
              ),
              ListTile(
                leading: Icon(Icons.share,
                  color: Colors.white,),
                title: Text('Share',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white
                  ),),
                onTap: () {
                 // shareApkFile();
                 Share.share('Quran app\n'
                     'you can develop it from my github github.com/sohaila2');
                },
              ),
              ListTile(
                leading: Icon(Icons.mode_comment_outlined,
                  color: Colors.white,),
                title: Text('Feedback',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white
                  ),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  FeedbackScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app,
                  color: Colors.white,),
                title: Text('Exit',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white
                  ),),
                onTap: () {
                  SystemNavigator.pop();
                },
              ),
              // Add more ListTile widgets for additional menu items
            ],
          ),
        ),
      ),
    );
  }
  Future<String> getApkFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String apkFilePath = '/home/sohaila/AndroidStudioProjects/qibla_finder_app/build/app/outputs/flutter-apk/app-release.apk';
    print('APK File Path: $apkFilePath');
    return apkFilePath;
  }

  void shareApkFile() async {
    try {
      String apkFilePath = await getApkFilePath();

      if (await doesFileExist(apkFilePath)) {
        await Share.shareFiles([apkFilePath], text: 'Check out this app!');
      } else {
        print('Error sharing APK: File does not exist.');
      }
    } catch (e) {
      print('Error sharing APK: $e');
    }
  }

  Future<bool> doesFileExist(String filePath) async {
    File file = File(filePath);
    return await file.exists();
  }


}