

import 'package:flutter/cupertino.dart';
import 'package:qibla_finder_app/screens/duas/praying/duas_while_praying.dart';

class DuasModel{
  String title;
  String image;
  Widget screen; // New property to hold the screen widget for navigation
  DuasModel({required this.title, required this.image,required this.screen});

}

List<DuasModel> duasList = [
  DuasModel(title: 'Eating', image: "assets/images/Group 27.png", screen: DuasWhilePrayingScreen()),
  DuasModel(title: 'Prayer',image: "assets/images/Group 29.png",screen: DuasWhilePrayingScreen()),
  DuasModel(title: 'Rest Room',image: "assets/images/Group 28.png",screen: DuasWhilePrayingScreen()),
  DuasModel(title: 'Family',image: "assets/images/Group 30.png",screen: DuasWhilePrayingScreen()),
  DuasModel(title: 'Rain',image: "assets/images/Group 31.png",screen: DuasWhilePrayingScreen()),
  DuasModel(title: 'Travel',image: "assets/images/SVGRepo_iconCarrier (1).png",screen: DuasWhilePrayingScreen()),

];