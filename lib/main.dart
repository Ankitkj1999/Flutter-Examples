import 'package:flutter/material.dart';
import 'package:flutter_firestore/screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Photo',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Home(),
    );
  }
}
