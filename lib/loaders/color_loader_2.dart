import 'package:flutter/material.dart';
import 'dart:math';

class ColorLoader2 extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Color color3;

  const ColorLoader2({
    Key? key,
    this.color1 = Colors.deepOrangeAccent,
    this.color2 = Colors.yellow,
    this.color3 = Colors.lightGreen,
  }) : super(key: key);

  @override
  _ColorLoader2State createState() => _ColorLoader2State();
}

class _ColorLoader2State extends State<ColorLoader2>
    with TickerProviderStateMixin {
  late final AnimationController controller1;
  late final AnimationController controller2;
  late final AnimationController controller3;

  late final Animation<double> animation1;
  late final Animation<double> animation2;
  late final Animation<double> animation3;

  @override
  void initState() {
    super.initState();

    controller1 = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this)
      ..repeat();
    controller2 = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this)
      ..repeat();
    controller3 = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this)
      ..repeat();

    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller1, curve: Curves.linear));
    animation2 = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: controller2, curve: Curves.easeIn));
    animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller3, curve: Curves.decelerate));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RotationTransition(
              turns: animation1,
              child: CustomPaint(
                painter: Arc1Painter(widget.color1),
              ),
            ),
            RotationTransition(
              turns: animation2,
              child: CustomPaint(
                painter: Arc2Painter(widget.color2),
              ),
            ),
            RotationTransition(
              turns: animation3,
              child: CustomPaint(
                painter: Arc3Painter(widget.color3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
}

class Arc1Painter extends CustomPainter {
  final Color color;

  Arc1Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawArc(rect, 0, 0.5 * pi, false, paint);
    canvas.drawArc(rect, 0.6 * pi, 0.8 * pi, false, paint);
    canvas.drawArc(rect, 1.5 * pi, 0.4 * pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Arc2Painter extends CustomPainter {
  final Color color;

  Arc2Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(
      size.width * 0.1,
      size.height * 0.1,
      size.width * 0.8,
      size.height * 0.8,
    );

    canvas.drawArc(rect, 0, 0.5 * pi, false, paint);
    canvas.drawArc(rect, 0.8 * pi, 0.6 * pi, false, paint);
    canvas.drawArc(rect, 1.6 * pi, 0.2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Arc3Painter extends CustomPainter {
  final Color color;

  Arc3Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(
      size.width * 0.2,
      size.height * 0.2,
      size.width * 0.6,
      size.height * 0.6,
    );

    canvas.drawArc(rect, 0, 0.9 * pi, false, paint);
    canvas.drawArc(rect, 1.1 * pi, 0.8 * pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
