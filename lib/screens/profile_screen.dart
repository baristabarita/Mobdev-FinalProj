import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_weather/models/StorageItem.dart';
import 'package:weather_weather/screens/login_screen.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/screens/forecast_screen.dart';
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
      backgroundColor: Color(0xFF4A91FF),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(45, 1.2 * kToolbarHeight, 45, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 600,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'User Profile',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        'Welcome to your profile screen!',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    FutureBuilder(
                      future: getUserDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          User? user = snapshot.data as User?;
                          if (user == null) {
                            return Text('No user logged in.');
                          } else {
                            String displayName =
                                user.displayName ?? user.email!.split('@')[0];
                            String email = user.email ?? "";

                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 75.0,
                                  backgroundImage: user.photoURL != null
                                      ? NetworkImage(user.photoURL!)
                                      : AssetImage('assets/default_pfp.jpg')
                                          as ImageProvider<Object>?,
                                ),
                                InfoField(
                                    labelText: 'Full Name',
                                    content: displayName),
                                SizedBox(
                                  height: 20,
                                ),
                                InfoField(
                                    labelText: 'Email Address', content: email),
                                SizedBox(height: 50.0),
                                ElevatedButton(
                                  onPressed: () => logoutUser(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: Size(150.0, 40),
                                  ),
                                  child: Text('Log Out'),
                                ),
                              ],
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, DashboardScreen.routeName);
          } else if (index == 1) {
            Navigator.pushNamed(context, ForecastScreen.routeName);
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

// Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/bg_1.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(80.0),
//               child: Text(
//                 'User Profile',
//                 style: TextStyle(
//                   fontSize: 30.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   shadows: [
//                     Shadow(
//                       color: Colors.grey, // Set the shadow color
//                       offset: Offset(2.0, 2.0), // Set the shadow offset
//                       blurRadius: 4.0, // Set the blur radius
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 50.0),
//                 Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.all(16.0),
//                   child: Text(
//                     'Welcome to your profile screen!',
//                     style: TextStyle(
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//                 FutureBuilder(
//                   future: getUserDetails(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       User? user = snapshot.data as User?;
//                       if (user == null) {
//                         return Text('No user logged in.');
//                       } else {
//                         String displayName =
//                             user.displayName ?? user.email!.split('@')[0];
//                         String email = user.email ?? "";

//                         return Column(
//                           children: [
//                             // Circular icon (using Photo URL or default person icon)
//                             CircleAvatar(
//                               radius: 50.0,
//                               backgroundImage: user.photoURL != null
//                                   ? NetworkImage(user.photoURL!)
//                                   : AssetImage('assets/default_pfp.jpg')
//                                       as ImageProvider<Object>?,
//                             ),
//                             // Display Name
//                             InfoField(
//                                 labelText: 'Full Name', content: displayName),
//                             // Email Address
//                             InfoField(
//                                 labelText: 'Email Address', content: email),
//                             SizedBox(height: 20.0),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Handle logout button press
//                                 logoutUser(context);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                                 foregroundColor: Colors.blue,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       20.0), // Set the border radius
//                                 ),
//                                 minimumSize: Size(150.0, 40),
//                               ),
//                               child: Text('Log Out'),
//                             ),
//                           ],
//                         );
//                       }
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),