import 'package:flutter/material.dart';
import 'package:qibla_finder_app/models/names_of_allah_model.dart';

class NamesOfAllahItem extends StatelessWidget {
   NamesOfAllahItem({super.key, required this.namesOfAllahModel});
final NamesOfAllahModel namesOfAllahModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0,bottom: 6.0),
      child: Image.asset(namesOfAllahModel.name,
      width: 340,
      height: 110,),
    );
  }
}
