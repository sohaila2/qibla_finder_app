import 'package:flutter/material.dart';

import '../../../widgets/drawer_widget.dart';
import '../../../widgets/linear_color.dart';

class AfterEatingDuaa extends StatelessWidget {
  AfterEatingDuaa({super.key});

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
        height: double.infinity,
        decoration: buildContainerDecoration(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("After Eating",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600, fontSize: 25
                      ),),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 341,
                      decoration: BoxDecoration(
                        color: Color(0xffEBD59A),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("الحمد لله الذي أطعمني هذا ورزقنيه من غير حول مني ولا قوة، الحمد لله الذي أطعمنا وسقانا وجعلنا مسلمين، الحمد لله الذي أطعم وسقى، وسوغه وجعل له مخرجًا",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400
                                ),),
                              SizedBox(
                                height: 12,
                              ),
                              Text("Praise be to God, who fed me this and provided me with it without any power or strength on my part. Praise be to God, who fed us and gave us drink and made us Muslims. Praise be to God, who fed and gave us water, and made it possible for it and made a way out for it.",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400
                                ),)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
