import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:qibla_finder_app/screens/prayer_times_screen.dart';

import '../widgets/drawer_widget.dart';
import '../widgets/linear_color.dart';
import '../widgets/navigation_bar.dart';
import 'more_options_screen.dart';


class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

class _QiblahScreenState extends State<QiblahScreen> with SingleTickerProviderStateMixin{
  String currentLocation = 'Loading...';
  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getLocation();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);

  }

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

  int selectedIndex = 0; // Default selected index is 0

  List<String> compassImages = [
    "assets/images/Group 12.png",
    "assets/images/Group 13 (1).png",
    "assets/images/Group 15.png",
    "assets/images/Group 16.png",
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
                  height: 12,
                ),
                 Text("Compass",
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.w500
                 ),),
                 SizedBox(
                  height: 200,
                  child:  StreamBuilder(
                    stream: FlutterQiblah.qiblahStream,
                    builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                      {
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      final qiblahDirection = snapshot.data!;

                      return Center(
                        child:
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Transform.rotate(
                              angle: (qiblahDirection.direction * (pi / 180) * -1),
                              child: Image.asset(
                                  compassImages[selectedIndex],
                                scale: 0.2,
                              ),
                            ),
                            Transform.rotate(
                              angle: (qiblahDirection.qiblah * (pi / 180) * -1),
                              alignment: Alignment.center,
                              child: Image.asset(
                                  "assets/images/needle.png"
                              ),
                            ),
                            // Positioned(
                            //   bottom: 0,
                            //   child: Text("${qiblahDirection.offset.toStringAsFixed(3)}°"),
                            // )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Image.asset("assets/images/Group 12.png"),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      child: Image.asset("assets/images/Group 13 (1).png"),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Image.asset("assets/images/Group 15.png"),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                      child: Image.asset("assets/images/Group 16.png"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTabTapped: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrayerTimesScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MoreOptionsScreen(),
              ),
            );
          }
        },
      ),

    );
  }
}
