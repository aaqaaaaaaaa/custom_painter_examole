import 'package:custom_painter_examole/custom_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

  var object = ClockPainter();

  var object2 = object;
  object.dateTime = DateTime(2010);
  print(object.dateTime);
  print(object2.dateTime);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ClockView(),
    );
  }
}
