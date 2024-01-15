import 'package:flutter/material.dart';
import 'package:qibla_finder_app/models/names_of_allah_model.dart';
import 'package:qibla_finder_app/widgets/names_of_allah_item.dart';

import '../widgets/linear_color.dart';

class NamesOfAllahScreen extends StatelessWidget {
  const NamesOfAllahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Asma-Ul-Husna",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 26.0,top: 8.0),
              child: Column(
                children: [
                  Image.asset("assets/images/namesOFAllah/773fb6ca9b42af9353ab81219789a35b (1).png"),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NamesOfAllahItem(namesOfAllahModel: namesOfAllahList1[index]);
                    },
                    itemCount: namesOfAllahList1.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset("assets/images/namesOFAllah/Rectangle 162.png"),
                            SizedBox(height: 8.0,),
                            Image.asset("assets/images/namesOFAllah/Group 57.png"),
                          ],
                        ),
                        SizedBox(width: 8.0,),
                  
                        Image.asset("assets/images/namesOFAllah/Group 56.png"),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NamesOfAllahItem(namesOfAllahModel: namesOfAllahList2[index]);
                    },
                    itemCount: namesOfAllahList2.length,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Image.asset("assets/images/namesOFAllah/Group 60.png"),
                            SizedBox(width: 8.0,),
                  
                            Image.asset("assets/images/namesOFAllah/Rectangle 164.png"),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0,),
                      Image.asset("assets/images/namesOFAllah/Group 61.png"),
                      SizedBox(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Row(
                          children: [
                            Image.asset("assets/images/namesOFAllah/Rectangle 165.png"),
                            SizedBox(width: 8.0,),
                  
                            Image.asset("assets/images/namesOFAllah/Rectangle 164 (1).png")
                  
                          ],
                        ),
                      ),
                      SizedBox(height: 8.0,),
                      Image.asset("assets/images/namesOFAllah/Rectangle 166.png")
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
