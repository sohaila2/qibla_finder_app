import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:qibla_finder_app/screens/more_options_screen.dart';
import 'package:qibla_finder_app/screens/qibla_screen.dart';

import '../widgets/drawer_widget.dart';
import '../widgets/linear_color.dart';
import '../widgets/navigation_bar.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen>
    with SingleTickerProviderStateMixin {
  String currentLocation = 'Loading...';
  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;
  Location location = new Location();
  LocationData? _currentPosition;
  double? latitude, longitude;
  List<Prayer> prayerTimesList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    latitude = _currentPosition!.latitude!;
    longitude = _currentPosition!.longitude!;
  }

  @override
  void initState() {
    super.initState();
    getLocation();
    getLoc();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      List<geocoding.Placemark> placemarks = await geocoding
          .placemarkFromCoordinates(position.latitude, position.longitude,
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

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal('en');
    var _hijiri = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE, d MMM yyyy');
    var formatted = format.format(day);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
          height: double.infinity,
          decoration: buildContainerDecoration(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: FutureBuilder(
                  future: getLoc(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    // Check if location data is available
                    if (latitude == null || longitude == null) {
                      return Text('Location data is not available.');
                    }

                    // Now you can use latitude and longitude safely
                    final myCoordinates = Coordinates(latitude!, longitude!);
                    final params = CalculationMethod.egyptian.getParameters();
                    params.madhab = Madhab.hanafi;
                    final prayerTimes =
                        PrayerTimes.today(myCoordinates, params);

                    // Get prayer times for the current date
                    final now = DateTime.now();
                    final fajrTime = prayerTimes.fajr;
                    final dhuhrTime = prayerTimes.dhuhr;
                    final asrTime = prayerTimes.asr;
                    final maghribTime = prayerTimes.maghrib;
                    final ishaTime = prayerTimes.isha;

                    final todayPrayerTimes = {
                      'Fajr': fajrTime,
                      'Dhuhr': dhuhrTime,
                      'Asr': asrTime,
                      'Maghrib': maghribTime,
                      'Isha': ishaTime,
                    };

                    // Find the earliest upcoming prayer
                    final upcomingPrayer = todayPrayerTimes.entries.firstWhere(
                      (entry) => entry.value.isAfter(now),
                      orElse: () => todayPrayerTimes.entries.first,
                    );
                    final scheduledTime =
                        DateFormat.jm().format(upcomingPrayer.value);
                    // Calculate time left until the upcoming prayer
                    Duration timeLeft;
                    if (now.isBefore(upcomingPrayer.value)) {
                      timeLeft = upcomingPrayer.value.difference(now);
                    } else {
                      // If the upcoming prayer has already passed today, calculate time left for tomorrow's Fajr
                      final tomorrowFajr = prayerTimes.fajr;
                      timeLeft = tomorrowFajr.difference(now);
                    }

                    // Adjust the calculation for the scenario where the upcoming prayer is after midnight
                    if (upcomingPrayer.key == 'Fajr' &&
                        timeLeft.inHours.isNegative) {
                      final todayFajr = prayerTimes.fajr;
                      timeLeft = upcomingPrayer.value
                          .add(Duration(days: 1))
                          .difference(now);
                    }

                    print('Earliest Prayer Time: ${upcomingPrayer.key}');
                    print(
                        'Time Left for ${upcomingPrayer.key}: ${timeLeft.inHours} hours');
                    return SingleChildScrollView(
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
                          Container(
                            width: 311,
                            height: 150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff030B58),
                                  Color(0xff212B89),
                                  Color(0xff414995),
                                  Color(0xff2A38B6),

                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.1,0.3,0.4,0.6],
                                tileMode: TileMode.clamp,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, top: 12.0, bottom: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${upcomingPrayer.key}\n$scheduledTime',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),),
                                      Text(
                                        'Time left\n${timeLeft.inHours}:${(timeLeft.inMinutes % 60).toString().padLeft(2, '0')}:${(timeLeft.inSeconds % 60).toString().padLeft(2, '0')}',
                                        style: TextStyle(
                                            color: Colors.white,
                                          fontSize: 15,
                                        ),  ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Image.asset("assets/images/OBJECTS.png"),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Today Prayer Times",
                            style: TextStyle(fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff6D591B)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Image.asset("assets/images/Rectangle 50.png"),
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff030B58),
                                              Color(0xff212B89),
                                              Color(0xff414995),
                                              Color(0xff2A38B6),

                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.1,0.3,0.4,0.6],
                                            tileMode: TileMode.clamp,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'SunRise',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                          ),
                                          Text(
                                            DateFormat.jm()
                                                .format(prayerTimes.sunrise),
                                            style: TextStyle(
                                              fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: 37,
                                      width: 55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(

                                  children: [
                                    Image.asset("assets/images/Rectangle 54.png"),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff030B58),
                                              Color(0xff212B89),
                                              Color(0xff414995),
                                              Color(0xff2A38B6),

                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.1,0.3,0.4,0.6],
                                            tileMode: TileMode.clamp,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Duhr',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            DateFormat.jm()
                                                .format(prayerTimes.dhuhr),
                                            style: TextStyle(
                                              fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: 37,
                                      width: 55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  children: [
                                    Image.asset("assets/images/Rectangle 53.png"),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff030B58),
                                              Color(0xff212B89),
                                              Color(0xff414995),
                                              Color(0xff2A38B6),

                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.1,0.3,0.4,0.6],
                                            tileMode: TileMode.clamp,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Asr',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            DateFormat.jm()
                                                .format(prayerTimes.asr),
                                            style: TextStyle(
                                              fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: 37,
                                      width: 55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  children: [
                                    Image.asset("assets/images/Rectangle 51.png"),
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff030B58),
                                              Color(0xff212B89),
                                              Color(0xff414995),
                                              Color(0xff2A38B6),

                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.1,0.3,0.4,0.6],
                                            tileMode: TileMode.clamp,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Maghrib',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            DateFormat.jm()
                                                .format(prayerTimes.maghrib),
                                            style: TextStyle(
                                              fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: 37,
                                      width: 55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  children: [
                                    Image.asset("assets/images/Rectangle 52.png"),
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff030B58),
                                              Color(0xff212B89),
                                              Color(0xff414995),
                                              Color(0xff2A38B6),

                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.1,0.3,0.4,0.6],
                                            tileMode: TileMode.clamp,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Isha',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            DateFormat.jm()
                                                .format(prayerTimes.isha),
                                            style: TextStyle(
                                              fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: 37,
                                      width: 55,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  children: [
                                    Image.asset("assets/images/Rectangle 50.png"),
                                    Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff030B58),
                                              Color(0xff212B89),
                                              Color(0xff414995),
                                              Color(0xff2A38B6),

                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0.1,0.3,0.4,0.6],
                                            tileMode: TileMode.clamp,
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(5))
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Fajr',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            DateFormat.jm()
                                                .format(prayerTimes.fajr),
                                            style: TextStyle(
                                              fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: 37,
                                      width: 55,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTabTapped: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QiblahScreen(),
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
