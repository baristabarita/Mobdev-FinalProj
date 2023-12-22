import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_weather/models/StorageItem.dart';
import 'package:weather_weather/screens/login_screen.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/services/StorageServices.dart';
import 'package:weather_weather/widgets/InfoField.dart';
import 'package:weather_weather/widgets/BottomNavbar.dart'; // Import the BottomNavbar widget

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageService storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to your profile screen!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(
            future: getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                User? user = snapshot.data as User?;
                if (user == null) {
                  return Text('No user logged in.');
                } else {
                  String displayName = user.displayName ?? user.email!.split('@')[0];
                  String email = user.email ?? "";

                  return Column(
                    children: [
                      // Circular icon (using Photo URL or default person icon)
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: user.photoURL != null
                            ? NetworkImage(user.photoURL!)
                            : AssetImage('assets/default_pfp.jpg') as ImageProvider<Object>?,
                      ),
                      SizedBox(height: 20.0),
                      // Display Name
                      InfoField(labelText: 'Full Name', content: displayName),
                      // Email Address
                      InfoField(labelText: 'Email Address', content: email),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle logout button press
                          logoutUser(context);
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 1, // Set the appropriate index for the Profile screen
        onTap: (index) {
          // Handle navigation or any other logic based on the selected index
          // You can add more cases for other screen navigation if needed
          if (index == 0) {
            Navigator.pushNamed(context, DashboardScreen.routeName);
          }
        },
      ),
    );
  }

  Future<User?> getUserDetails() async {
    User? user = _auth.currentUser;
    return user;
  }

  void logoutUser(BuildContext context) async {
    try {
      await _auth.signOut();
      await storageService.saveData(StorageItem("uid", null));
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
