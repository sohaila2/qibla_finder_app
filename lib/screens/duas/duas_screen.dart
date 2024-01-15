import 'package:flutter/material.dart';
import 'package:qibla_finder_app/models/duas_model.dart';
import 'package:qibla_finder_app/screens/duas/eating/duas_while_eating.dart';
import 'package:qibla_finder_app/screens/duas/family/duas_for_family.dart';
import 'package:qibla_finder_app/screens/duas/praying/duas_while_praying.dart';
import 'package:qibla_finder_app/screens/duas/rain/duas_while_raining.dart';
import 'package:qibla_finder_app/screens/duas/rest_room/duas_for_rest_room.dart';
import 'package:qibla_finder_app/screens/duas/travel/duas_while_traveling.dart';
import 'package:qibla_finder_app/screens/quran_screen.dart';
import 'package:qibla_finder_app/widgets/dua_item.dart';

import '../../widgets/drawer_widget.dart';
import '../../widgets/linear_color.dart';



class DuasScreen extends StatefulWidget {
  const DuasScreen({super.key});

  @override
  State<DuasScreen> createState() => _DuasScreenState();
}

class _DuasScreenState extends State<DuasScreen> {
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
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0,right: 18.0,top: 40.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 12.0, // Spacing between columns
              mainAxisSpacing: 26.0, // Spacing between rows
            ),
            itemBuilder: (context, index) {
              return DuaItem(duasModel: duasList[index],
              onTap: (){
                navigateToScreen(context, duasList[index]);
              },);
            },
            itemCount: duasList.length,
          ),
        ),
      ),
    );
  }
  void navigateToScreen(BuildContext context, DuasModel duasModel) {
    // Determine the screen to navigate based on the pressed dua
    Widget screen;
    switch (duasModel.title.toLowerCase()) {
      case 'eating':
        screen = DuasWhileEatingScreen();
        break;
      case 'prayer':
        screen = DuasWhilePrayingScreen();
        break;
      case 'rest room':
        screen = DuasForRestRoomScreen();
        break;
      case 'family':
        screen = DuasForFamilyScreen();
        break;
      case 'rain':
        screen = DuasWhileRainingScreen();
        break;
      case 'travel':
        screen = DuasWhileTravelingScreen();
        break;

      default:
      // If no specific screen is defined, you can navigate to a default screen
        screen = DuasWhilePrayingScreen();
        break;
    }

    // Navigate to the selected screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
