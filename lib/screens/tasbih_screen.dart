import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../widgets/drawer_widget.dart';
import '../widgets/linear_color.dart';
class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int count = 0;
  bool isPaused = false;

  void counter() {
    if (!isPaused) {
      setState(() {
        count++;
      });
    }
  }

  void reset() {
    setState(() {
      count = 0;
    });
  }

  void togglePause() {
    setState(() {
      isPaused = !isPaused;
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            iconSize: 40,
            color: Colors.white,
            onPressed: reset,
            icon: Icon(Icons.refresh),
          )
        ],
        title: Text(
          "Tasbih",
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
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 311,
                          height: 158,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Color(0xffddb500)
                          ),
                        ),
                        Positioned(
                            left: 25.5,
                            right: 28,
                            top: 30,
                            child: MyArc(diameter: 260)),
                        Positioned(
                            top: 60,
                            left: 80,
                            right: 60,
                            child: Text("أستغفر الله",
                              style: TextStyle(
                                  color: Color(0xffD9A81F),
                                  fontSize: 32,
                                fontWeight: FontWeight.w400
                              ),)),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Image.asset("assets/images/Group 34.png",
                              width:310,
                              height:36
                          ),
                        ),
          
                      ],
                    ),
          
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(onPrimary: Colors.black,
                          backgroundColor: Color(0xffddb500),
                          side: BorderSide(color: Colors.black,width: 2.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),
                      child: Row(
                        children: [
                          Text("Beep",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(width: 12,),
                          Container(
                            width: 63,
                            height: 20,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Center(child: Text(count.toString())),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(onPrimary: Colors.black,
                          backgroundColor: Color(0xffddb500),
                          side: BorderSide(color: Colors.black,width: 2.0),

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )),
                      onPressed: reset,
                      child: Text("Reset",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text("أستغفر الله",
                  style: TextStyle(
                    fontFamily: 'quran',
                      fontSize: 30,
                      fontWeight: FontWeight.w400
                  ),),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 147,
                  height: 147,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffddb500), // Adjust color as needed
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        counter();
                      },
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black, // Adjust color as needed
                        ),
                        child: Center(
                            child: Text(
                          "Count",
                              style: TextStyle(color: Color(0xffddb500),fontWeight: FontWeight.w700,fontSize: 30),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom( shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),onPrimary: Colors.black,
                      backgroundColor: Color(0xffddb500)),
                  onPressed: togglePause,
                  child: Text(isPaused ? "Resume" : "Pause",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({super.key, this.diameter = 200});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}


class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: 247,
        width: 310,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
