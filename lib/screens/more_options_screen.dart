import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:qibla_finder_app/screens/duas/duas_screen.dart';
import 'package:qibla_finder_app/screens/names_of_allah_screen.dart';
import 'package:qibla_finder_app/screens/prayer_times_screen.dart';
import 'package:qibla_finder_app/screens/qibla_screen.dart';
import 'package:qibla_finder_app/screens/quran_screen.dart';
import 'package:qibla_finder_app/screens/tasbih_screen.dart';

import '../widgets/drawer_widget.dart';
import '../widgets/linear_color.dart';
import '../widgets/navigation_bar.dart';

class MoreOptionsScreen extends StatefulWidget {
  const MoreOptionsScreen({super.key});

  @override
  State<MoreOptionsScreen> createState() => _MoreOptionsScreenState();
}

class _MoreOptionsScreenState extends State<MoreOptionsScreen> {
  String currentLocation = 'Loading...';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
      );

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude,
          localeIdentifier: 'en_US');

      if (mounted) {
        setState(() {
          currentLocation = placemarks.first.country ?? 'Unknown Country';
        });
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }
  void initState() {
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('en');
    var _hijiri = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE, d MMM yyyy');
    var formatted = format.format(day);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            iconSize: 40,

            color: Colors.white,
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.sort),
          ),
          title: Text(
            "Qibla Finder",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
          ),
        ),
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        drawer: const DrawerWidget(),
      body: Container(
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 formatted,
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
               RichText(
                   text: TextSpan(children: [
                     TextSpan(
                         text: ('${_hijiri.hDay} '),
                         style: TextStyle(
                           fontSize: 20,
                         )),
                     TextSpan(
                       text: (_hijiri.longMonthName),
                       style: TextStyle(fontSize: 20),
                     ),
                     TextSpan(
                         text: (',${_hijiri.hYear}'),
                         style: TextStyle(fontSize: 20)),
                   ])),
               Row(
                 children: [
                   Container(
                       width: 120,
                       height: 42,
                       decoration: BoxDecoration(
                           borderRadius:
                           BorderRadius.all(Radius.circular(20)),
                           color: Color(0xff503112)),
                       child: SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(left: 6.0),
                               child: Icon(Icons.location_on_outlined,
                                 size: 30.0,
                                 color: Colors.white,),
                             ),
                             Text(
                               currentLocation,
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(fontSize: 18.0,
                                   color: Colors.white),
                             ),
                           ],
                         ),
                       )),
                   SizedBox(width: 40.0),
                   Image.asset("assets/images/Group (2).png",
                       scale: 1.4, fit: BoxFit.contain)
                 ],
               ),
                SizedBox(
                  height: 28,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Last Surahs",
                            style: TextStyle(
                              color: Color(0xff6E4C12),
                              fontWeight: FontWeight.w600,
                              fontSize: 17
                            ),),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  QuranScreen()));
                                },child: Image.asset("assets/images/Rectangle 53 (2).png"))
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text("Dua",
                              style: TextStyle(
                                  color: Color(0xff6E4C12),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17
                              ),),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  DuasScreen()));
                            },child: Image.asset("assets/images/Rectangle 52 (2).png"))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text("Tasbih",
                              style: TextStyle(
                                  color: Color(0xff6E4C12),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17
                              ),),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  TasbihScreen()));
                            },child: Image.asset("assets/images/Rectangle 51 (1).png"))
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text("Names Of Allah",
                              style: TextStyle(
                                  color: Color(0xff6E4C12),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17
                              ),),
                            SizedBox(
                              height: 8,
                            ),
                            GestureDetector(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  NamesOfAllahScreen()));
                            },child: Image.asset("assets/images/Rectangle 54 (1).png"))
                          ],
                        )
                      ],
                    ),
                  ],
                )
             ],
            ),
          ),
        ),
      ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 2,
          onTabTapped: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrayerTimesScreen(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      QiblahScreen(),
                ),
              );
            }
          },
        )

    );
  }
}
