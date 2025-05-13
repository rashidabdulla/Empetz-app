import 'package:flutter/material.dart';

class Myabout extends StatefulWidget {
  const Myabout({super.key});

  @override
  State<Myabout> createState() => _MyaboutState();
}

class _MyaboutState extends State<Myabout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'ABOUT',
          style: TextStyle(color: Colors.black),
        ),
  
      ),
    );
  }
}
