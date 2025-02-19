import 'package:flutter/material.dart';

class DeviceInfo {
  static bool isPortrait(BuildContext context) => MediaQuery.of(context).orientation == Orientation.portrait;
  static bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  }
