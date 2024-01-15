import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;
import '../models/surah.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/linear_color.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen>
    with TickerProviderStateMixin {
  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  ScrollController _controller = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    List<dynamic> surahDataList = data["chapters"];
    int startIndex = surahDataList.length - 6;
    startIndex = startIndex < 0 ? 0 : startIndex;
    List<dynamic> lastSixSurahs = surahDataList.sublist(startIndex);
    surahList = lastSixSurahs.map((item) => Surah.fromMap(item)).toList();

    debugPrint(surahList.length.toString());
    setState(() {});
  }

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
          "Last Surahs",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
        ),
      ),
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body: surahList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: buildContainerDecoration(),
              child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: chaptersList(
                        isReverse ? surahList.reversed.toList() : surahList),
                  ))),
    );
  }

  Widget chaptersList(List<Surah> chapters) {
    return GridView.builder(
      controller: _controller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 18.0, // Spacing between rows
      ),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                SurahPage(surah: chapters[index]),
          ),
        ),
        child: Container(
          width: 100.0, // Set the width to create a circle
          height: 110.0, // Set the height to create a circle
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white, // You can set the color of the circle
          ),
          child: Center(
            child: Text('سورة ${chapters[index].arabicName} ',
              style: TextStyle(
                  fontFamily: 'Aldhabi',
                  fontWeight: FontWeight.w600, fontSize: 22
              ),),
          ),
        ),
      ),
      itemCount: chapters.length,
    );
  }
}

class SurahPage extends StatelessWidget {
  final Surah surah;
  SurahPage({required this.surah});
  @override
  Widget build(BuildContext context) {
    int count = surah.versesCount;
    int index = surah.id;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        title:Text('سورة ${surah.arabicName} ',
          style: TextStyle(
              fontFamily: 'NotoNastaliqUrdu',
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25
          ),
        ),
        ),
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          decoration: buildContainerDecoration(),
          child: SafeArea(
            minimum: EdgeInsets.all(15),
            child: ListView(children: [
              Padding(
                padding: EdgeInsets.only(top: 12,bottom: 12),
                child: header(),
              ),
              SizedBox(
                height: 5,
              ),
              RichText(
                textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
                text: TextSpan(
                  children: [
                    for (var i = 1; i <= count; i++) ...{
                      TextSpan(
                        text: ' ' +
                            quran.getVerse(index, i, verseEndSymbol: false) +
                            ' ',
                        style: TextStyle(
                          fontFamily: 'Kitab',
                          fontSize: 25,
                          color: Colors.black87,
                        ),
                      ),
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: CircleAvatar(
                            child: Text(
                              '$i',
                              textAlign: TextAlign.center,
                              textScaleFactor: i.toString().length <= 2 ? 1 : .8,
                            ),
                            radius: 14,
                          ))
                    }
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
    // Text(
    //   surah.arabicName,
    //   style: TextStyle(
    //     fontFamily: 'Aldhabi',
    //     fontSize: 36,
    //     fontWeight: FontWeight.bold,
    //   ),
    // ),
    Text(
      ' ' + quran.basmala + ' ',
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontFamily: 'NotoNastaliqUrdu',
        fontSize: 24,
      ),
    ),
          ],
        );
  }
}
