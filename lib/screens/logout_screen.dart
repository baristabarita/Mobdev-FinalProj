// logout_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_weather/models/StorageItem.dart';
import 'package:weather_weather/screens/login_screen.dart';
import 'package:weather_weather/services/StorageServices.dart';

class LogoutScreen extends StatelessWidget {
  static String routeName = "/logout";
  final StorageService storageService = StorageService(); // Create an instance of StorageService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to log out?',
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle logout button press
                logoutUser(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void logoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await storageService.saveData(StorageItem("uid", null)); // Set uid to null in storage
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
