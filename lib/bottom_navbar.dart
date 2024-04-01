import 'package:flutter/material.dart';
import 'package:vehlocate/Home_page.dart';
import 'package:vehlocate/LiveRecordPage.dart';
import 'package:vehlocate/Profile_Page.dart';
import 'package:vehlocate/maps.dart';

class Bottomnavigationbar extends StatefulWidget {
  const Bottomnavigationbar({super.key});

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  int myCurrentIndex = 0;
  List pages = [
    const Home_page(),
    GoogleMapPage(),
    const LiveReading(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent going back
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 20,
              offset: Offset(2, 5),
            )
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.cyan,
              unselectedItemColor: Colors.grey,
              currentIndex: myCurrentIndex,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.map_outlined), label: 'Map'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.live_tv), label: 'Live Reading'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
        ),
        body: pages[myCurrentIndex],
      ),
    );
  }
}
