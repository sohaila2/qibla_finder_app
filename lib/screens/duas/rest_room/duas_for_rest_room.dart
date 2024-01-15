
import 'package:flutter/material.dart';
import 'package:qibla_finder_app/screens/duas/praying/before_ablution_duaa.dart';
import 'package:qibla_finder_app/screens/duas/rest_room/after_rest_room_duaa.dart';
import 'package:qibla_finder_app/screens/duas/rest_room/before_rest_room_duaa.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/linear_color.dart';

class DuasForRestRoomScreen extends StatelessWidget {
  DuasForRestRoomScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          iconSize: 40,
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.sort),
        ),
        title: Text(
          "Duas",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
        ),
      ),
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body: Container(
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                children: [
                  Text("Duas For Rest Room",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600, fontSize: 25
                    ),),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 94,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BeforeRestRoomDuaa()));
                    },style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      backgroundColor: Color(0xffEBD59A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                      ),
                    ), child:
                    Text("Before entering rest room",
                      style: TextStyle(
                          color: Color(0xff715104),
                          fontWeight: FontWeight.w600, fontSize: 22
                      ),)),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 94,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AfterRestRoomDuaa()));

                    },style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      backgroundColor: Color(0xffEBD59A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                      ),
                    ), child: Text("After getting out of rest romm",
                      style: TextStyle(
                          color: Color(0xff715104),
                          fontWeight: FontWeight.w600, fontSize: 22
                      ),
                    )),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
