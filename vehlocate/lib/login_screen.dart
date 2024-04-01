import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehlocate/DataFmSplashScreem.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(String username, String password) async {
    try {
      Response response = await http.get(
        Uri.parse(
          'https://data-fm.com//VehTecMobileCommon/ItlService.svc/URLAuthorization?ClientName=$username&Password=$password',
        ),
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          // Store username locally
          _storeUsernameLocally(username);
          // Show success dialog and navigate to the next screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DataFmSplashScreen(username: username),
            ),
          );
        } else {
          print('Login unsuccessful: ${responseData['status']}');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Wrong Credentials'),
                content: const Text('Login Unsuccessful.'),
                actions: <Widget>[
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
      print(e.toString());
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
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      hintText: 'Clientname',
                      hintStyle: TextStyle(fontSize: 15),
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
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(Icons.password)),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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
