import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      color: const Color(0xff2d2f41),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(-10, -10),
              blurRadius: 20),
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(10, 10),
              blurRadius: 20),
        ]),
        width: 300,
        height: 300,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          ),
        ),
      ),
    ));
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();


  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerY, centerX);

    var fillBrush = Paint()..color = const Color(0xff444974);
    var outlineBrush = Paint()
      ..color = const Color(0xffeaecff)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    var centerBrush = Paint()..color = const Color(0xffeaecff);

    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    var minHand = Paint()
      ..strokeCap = StrokeCap.round
      ..shader =
          const RadialGradient(colors: [Color(0xff748ef6), Color(0xff77ddff)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHand = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xffea74ab), Color(0xffc2f9fb)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    var hourHadX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHadY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHadX, hourHadY), hourHand);

    var minHadX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHadY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHadX, minHadY), minHand);

    var secHadX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHadY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHadX, secHadY), secHandBrush);
    canvas.drawCircle(center, 16, centerBrush);

    var outerRadius = radius;
    var innerRadius = radius - 14;

    var dashBrush = Paint()..color = const Color(0xffeaecff);

    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerRadius * cos(i * pi / 180);
      var y1 = centerX + outerRadius * sin(i * pi / 180);
      var x2 = centerX + innerRadius * cos(i * pi / 180);
      var y2 = centerX + innerRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
