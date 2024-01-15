
import 'package:flutter/material.dart';
import 'package:qibla_finder_app/screens/duas/praying/before_ablution_duaa.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/linear_color.dart';

class DuasForFamilyScreen extends StatelessWidget {
  DuasForFamilyScreen({super.key});

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
                  Text("Duas For Family",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600, fontSize: 25
                    ),),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    width: 341,
                    height: 548,
                    decoration: BoxDecoration(
                      color: Color(0xffEBD59A),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("يا رب إنّ عائلتي هي من أجمل هداياك، ومن أغلى مارزقتني، فاحفظهم لي وأسعدهم",
                        style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(
                              height: 12,
                            ),
                            Text("O God, my family is one of your most beautiful gifts, and one of the most precious things you have given me, so protect them for me and make them happy.”",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400
                              ),)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
