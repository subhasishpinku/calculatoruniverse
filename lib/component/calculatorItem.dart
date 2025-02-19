import 'package:flutter/material.dart';

class CalculatorItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final EdgeInsetsGeometry padding;

  const CalculatorItem({
    Key? key,
    required this.imagePath,
    required this.title,
    this.padding = const EdgeInsets.only(top: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: padding,
          child: Image.asset(imagePath),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Text(title),
        ),
      ],
    );
  }
}
