import 'package:flutter/material.dart';
import 'package:qibla_finder_app/screens/permission_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/background.png",
            fit: BoxFit.fill,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top:140.0),
              child: Text("Qibla Finder",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Colors.white
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120, // Adjust this value to position the button
            left: 60,
            right: 60,
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  PermissionScreen()));
            },style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff503112),
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),child: Text("Continue",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white
              ),)),
          ),
          Positioned(
              bottom: 40, // Adjust this value to position the button
              left: 40,
              right: 0,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: "By tapping the start you agree to the ",
                    ),
                    TextSpan(
                      text: "Terms of service\n",
                      style: TextStyle(

                        color: Color(0xff021BF9), // Change the color as needed
                      ),
                    ),
                    TextSpan(
                      text:     "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t& privacy Policy",
                      style: TextStyle(
                        color: Color(0xff021BF9), // Change the color as needed
                      ),
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
//
// Stack(
// fit: StackFit.expand,
// children: [
// Image.asset(
// "assets/images/background.png",
// fit: BoxFit.fill,
// ),
// Positioned(
// top: 50, // Adjust this value to move the second image down or up
// left: 0,
// right: 0,
// child: Image.asset(
// "assets/images/Group.png",
// ),
// ),
// Positioned(
// top: 146, // Adjust this value to move the third image up or down
// left: 0,
// right: 0,
// child: Image.asset(
// "assets/images/Objects.png",
// ),
// ),
// Center(
// child: Padding(
// padding: const EdgeInsets.only(top:180.0),
// child: Text("Qibla Finder",
// ),
// ),
// ),
// Positioned(
// bottom: 120, // Adjust this value to position the button
// left: 0,
// right: 0,
// child: ElevatedButton(onPressed: (){
// Navigator.push(context, MaterialPageRoute(builder: (context)=>
// PermissionScreen()));
// },child: Text("Continue")),
// ),
// Positioned(
// bottom: 40, // Adjust this value to position the button
// left: 0,
// right: 0,
// child: Text("By tapping the start you agree to the Terms of service\n& privacy Policy")),
// ],
// ),