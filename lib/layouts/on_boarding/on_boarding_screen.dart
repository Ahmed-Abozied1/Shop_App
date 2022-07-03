// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/component/component_screen.dart';
import 'package:shop_app/shared/network/local/shared_preferences.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.title, required this.image, required this.body});
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<BoardingModel> boarding = [
    BoardingModel(
        title: "tiitle 1", image: "assets/images/onboard1.png", body: "body1"),
    BoardingModel(
        title: "tiitle 2", image: "assets/images/onboard2.png", body: "body2"),
    BoardingModel(
        title: "tiitle 3", image: "assets/images/onboard3.png", body: "body3"),
  ];

  bool isLast = false;

  void skip() {
    CacheHelper.setData(value: true, key: 'onBoarding').then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageController = PageController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                style: ButtonStyle(),
                onPressed: () {
                 skip();
   
                
                },
                child: Text(
                  "SKIP",
                  style: TextStyle(
                      fontFamily: "Noto",
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5,
                        activeDotColor: defaultColor),
                  ),
                  FloatingActionButton(
                    backgroundColor: defaultColor,
                    onPressed: () {
                      if (isLast) {
                          skip();
                      } else {
                        pageController.nextPage(
                            duration: Duration(milliseconds: 700),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel modle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(child: Image(image: AssetImage(modle.image))),
          Text(
            modle.title,
            style: TextStyle(
              fontFamily: "Noto",
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(modle.body),
        ],
      );
}
