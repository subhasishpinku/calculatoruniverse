import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center( // Centers the entire content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers content within the column
          children: [
            Text("Page under construction"),
          ],
        ),
      ),
    );
  }
}
