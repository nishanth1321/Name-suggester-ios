import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vehlocate/SecondLoginScreen.dart'; // Import the LoginScreenTwo widget

class DataFmSplashScreen extends StatefulWidget {
  final String username;

  const DataFmSplashScreen({Key? key, required this.username})
      : super(key: key);

  @override
  _DataFmSplashScreenState createState() => _DataFmSplashScreenState();
}

class _DataFmSplashScreenState extends State<DataFmSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer to navigate after 4 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreenTwo()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCircle(
              color: Colors.cyan,
              size: 50.0,
            ),
            SizedBox(height: 10),
            Text(
              widget.username, // Display the username
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
