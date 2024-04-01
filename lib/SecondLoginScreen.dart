import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:vehlocate/login_screen.dart';
import 'bottom_navbar.dart';

class LoginScreenTwo extends StatefulWidget {
  const LoginScreenTwo({super.key});

  @override
  State<LoginScreenTwo> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenTwo> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(String username1, String password1) async {
    try {
      Response response = await get(
        Uri.parse(
          'https://data-fm.com/VehLocateAPI/ItlService.svc/LoginV1?username=$username1&password=$password1&usertype=1',
        ),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          // Store username locally
          await _storeUsernameLocally(username1);

          // Show success dialog
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Bottomnavigationbar()));
        } else {
          print('Login unsuccessful: ${responseData['status']}');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: const EdgeInsets.fromLTRB(
                    1.0, 1.0, 1.0, 1.0), // Adjust padding as needed
                title: const Text('Wrong Credentials'),

                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _storeUsernameLocally(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    print('Username stored: $username');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: Image.asset('assets/images/app_logo.png'),
                ),
                const SizedBox(height: 20),
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: ['FMS', 'ETS'],
                  fontSize: 17,
                  activeBgColors: [
                    [Colors.cyan],
                    [Colors.cyan]
                  ],
                  onToggle: (index) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      hintText: 'username',
                      hintStyle: TextStyle(fontSize: 17),
                      prefixIcon: Icon(Icons.person)),
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: 'password',
                      hintStyle: TextStyle(fontSize: 17),
                      prefixIcon: Icon(Icons.password)),
                ),

                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    /* login(usernameController.text, passwordController.text);*/
                    String username = usernameController.text;
                    String password = passwordController.text;
                    if (username.isEmpty || password.isEmpty) {
                      if (username.isEmpty && password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.black38,
                            content: Text('Enter username and password.'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(bottom: 15),
                          ),
                        );
                      } else if (username.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.black38,
                            content: Text('Enter username.'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(bottom: 15),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.black45,
                            content: Text('Enter password.'),
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(bottom: 15),
                          ),
                        );
                      }
                    } else {
                      login(username, password);
                    }
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add some space
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Switch Client ',
                    style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Column(
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                      Text(
                        'Copyright Powered by Vehtech Software Solutions',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
