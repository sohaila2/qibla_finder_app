import 'package:flutter/material.dart';
import 'package:qibla_finder_app/models/duas_model.dart';


class DuaItem extends StatelessWidget {
  const DuaItem({super.key, required this.duasModel, this.onTap});
  final DuasModel duasModel;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.0, // Set the width to create a circle
        height: 120.0, // Set the height to create a circle
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white, // You can set the color of the circle
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             Image.asset(duasModel.image),
              Text(duasModel.title,
              style: TextStyle(
                color: Color(0xff704E13),
                fontSize: 25,
                fontWeight: FontWeight.w600
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
