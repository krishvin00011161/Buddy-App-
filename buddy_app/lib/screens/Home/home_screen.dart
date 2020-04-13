import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey,
      ),
    );
  }
}
