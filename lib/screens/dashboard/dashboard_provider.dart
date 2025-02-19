import 'package:calculatoruniverse/component/autoSlider%20.dart';
import 'package:calculatoruniverse/component/home_carousel_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class DashboardProvider with ChangeNotifier {
  RxInt pageIndex = 0.obs;
  List<Widget> demo = [
    AutoSlider(),
    AutoSlider(),
    AutoSlider(),
  ];
   final List<String> images = [
    "assets/images/slide1.png",
    "assets/images/slide2.png",
    "assets/images/slide3.png",
  ];
}
