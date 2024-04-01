import 'package:flutter/material.dart';

class LiveReading extends StatelessWidget {
  const LiveReading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Live Recording'),
        backgroundColor: Colors.black12,
      ),
      body: const Center(
          child: Text(
        'LiveReading',
        style: TextStyle(fontSize: 30),
      )),
    );
  }
}
