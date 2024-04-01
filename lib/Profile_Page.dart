import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        backgroundColor: Colors.black12,
      ),
      body: const Center(
          child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 30),
      )),
    );
  }
}
