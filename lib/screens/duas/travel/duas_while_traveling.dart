

import 'package:flutter/material.dart';
import 'package:qibla_finder_app/screens/duas/praying/before_ablution_duaa.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/linear_color.dart';

class DuasWhileTravelingScreen extends StatelessWidget {
  DuasWhileTravelingScreen({super.key});

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
        height: double.infinity,
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Duas While Traveling",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600, fontSize: 25
                      ),),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                      width: 341,
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
                              Text("سُبْحَانَ الّذِي سَخّرَ لَنَا هَذَا وَمَا كُنّا لَهُ مُقْرِنِينَ، وَإِنّا إِلَىَ رَبّنَا لَمُنْقَلِبُونَ، اللّهُمّ إِنّا نَسْأَلُكَ فِي سَفَرِنَا هَذَا الْبِرّ وَالتّقْوَىَ، وَمِنَ الْعَمَلِ مَا تَرْضَىَ، اللّهُمّ هَوّنْ عَلَيْنَا سَفَرَنَا هَذَا، وَاطْوِ عَنّا بُعْدَهُ، اللّهُمّ أَنْتَ الصّاحِبُ فِي السّفَرِ، وَالْخَلِيفَةُ فِي الأَهْلِ، اللّهُمّ إِنّي أَعُوذُ بِكَ مِنْ وَعْثَاءِ السّفَرِ، وَكَآبَةِ الْمَنْظَرِ، وَسُوءِ الْمُنْقَلَبِ فِي الْمَالِ وَالأَهْلِ",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400
                                ),),
                              SizedBox(
                                height: 12,
                              ),
                              Text("Glory be to Him who has subjected this to us, and we would not have been able to do it. Indeed, to our Lord we will return. O God, we ask you on this journey of righteousness and piety, and from Work as you please. O God, make this journey easy for us, and make it easy for us after it. O God, you are the companion in the journey and the successor in the family. O God I seek refuge in You from the hardships of travel, the gloominess of the outlook, and the bad upheavals in money and family",
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
      ),
    );
  }
}
