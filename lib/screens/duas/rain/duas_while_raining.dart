
import 'package:flutter/material.dart';
import 'package:qibla_finder_app/screens/duas/praying/before_ablution_duaa.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/linear_color.dart';

class DuasWhileRainingScreen extends StatelessWidget {
  DuasWhileRainingScreen({super.key});

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
                    Text("Duas While Raining",
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
                              Text(" اللَّهمَّ صيِّبًا نافعًا.مُطِرْنَا بفَضْلِ اللَّهِ ورَحْمَتِهِ.اللَّهُمَّ أغِثْنَا، اللَّهُمَّ أغِثْنَا، اللَّهُمَّ أغِثْنَا.سبحانَ الذي يسبحُ الرعدُ بحمدِه والملائكةُ من خيفتِه.اللَّهمَّ اسْقِ عِبادَك وبهائمَك، وانشُرْ رحْمتَك، وأَحْيِ بلدَك الميِّتَ.اللَّهُمَّ حَوَالَيْنَا ولَا عَلَيْنَا، اللَّهُمَّ علَى الآكَامِ والظِّرَابِ، وبُطُونِ الأوْدِيَةِ، ومَنَابِتِ الشَّجَرِ.",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400
                                ),),
                              SizedBox(
                                height: 12,
                              ),
                              Text("Oh God, grant us a beneficial rain. Rain us with God’s grace and mercy. Oh God, help us, O God, help us, O God, help us. Glory be to Him whom the thunder praises and the angels praise from His fear. O God, give water to Your servants and livestock, Spread your mercy and revive your dead country. Oh God, around us and not against us, Oh God, on the hills and the hills, and the stomachs. Valleys and tree beds.",
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
