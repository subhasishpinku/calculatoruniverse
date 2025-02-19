// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calculatoruniverse/constants/colors.dart';
import 'package:flutter/material.dart';

Widget homeCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [    
          Image.asset("assets/images/slide1.png"),
          Image.asset("assets/images/slide2.png"),
          Image.asset("assets/images/slide3.png"),

        ],
      ),
    ],
  );
}
