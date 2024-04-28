// ignore_for_file: library_private_types_in_public_api, unnecessary_import, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new, sized_box_for_whitespace, sort_child_properties_last

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import '../widgets/example_slider.dart';
import '../models/item_data.dart';

class LiquidSwipeScreen extends StatefulWidget {
  @override
  _LiquidSwipeScreen createState() => _LiquidSwipeScreen();
}

class _LiquidSwipeScreen extends State<LiquidSwipeScreen> {
  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  List<ItemData> data = [
    ItemData(Color.fromRGBO(240, 130, 149, 1.0), "assets/Animation1.json",
        "Motivate Yourself\nTo Reach Your\nGoals!"),
    ItemData(
      Color.fromRGBO(213, 243, 255, 1.0),
      "assets/Animation2.json",
      "Choose Your Plan\nFor Success\nToday",
    ),
    ItemData(
      Color(0xFFF0DCC3),
      "assets/Animation4.json",
      "Enjoy Healthy\nLife!",
    ),
  ];

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  color: data[index].color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                      ),
                      Lottie.asset(
                        data[index].lottieFilePath,
                        height: 300,
                        width: 392,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                data[index].text1,
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Exo'),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      index == 4
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 70.0),
                              child: ExampleSlider(),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              fullTransitionValue: 880,
              enableSideReveal: true,
              preferDragFromRevealedArea: true,
              enableLoop: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(data.length, _buildDot),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: data.length - 1, duration: 700);
                  },
                  child: Text(
                    "Skip to End",
                    style: TextStyle(fontFamily: 'Exo',fontSize: 15),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                      page: liquidController.currentPage + 1 > data.length - 1
                          ? 0
                          : liquidController.currentPage + 1,
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontFamily: 'Exo',fontSize: 15),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
