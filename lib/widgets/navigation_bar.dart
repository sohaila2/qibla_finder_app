import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTabTapped,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffddb500),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(Icons.home, 0),
          buildNavItem(
              Image.asset(
                "assets/images/Group.png",
                scale: 1.6,
              ),
              1),
          buildNavItem(Icons.more_vert, 2),
        ],
      ),
    );
  }

  Widget buildNavItem(dynamic icon, int index) {
    return GestureDetector(
      onTap: () => widget.onTabTapped(index),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.currentIndex == index
              ? Colors.white
              : Colors.transparent,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: Color(0xff00ad9b),
            size: 30,
          ),
          child: icon is Widget ? icon : Icon(icon),
        ),
      ),
    );
  }
}


