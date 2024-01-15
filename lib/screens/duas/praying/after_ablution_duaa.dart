

import 'package:flutter/material.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/linear_color.dart';

class AfterAblutionDuaa extends StatelessWidget {
  AfterAblutionDuaa({super.key});

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
                  Text("After Ablution",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600, fontSize: 25
                    ),),
                  SizedBox(
                    height: 20,
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
                            Text(" أشهد أن لا إله إلا الله وأشهد أن محمداً عبده ورسوله، اللهم اجعلني من التوابين واجعلني من المتطهرين",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(
                              height: 12,
                            ),
                            Text("I bear witness that there is no god but God, and I bear witness that Muhammad is His servant and His Messenger. O God, make me one of those who repent and make me one of those who purify themselves.",
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
