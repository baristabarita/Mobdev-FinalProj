import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_weather/models/StorageItem.dart';
import 'package:weather_weather/screens/registration_screen.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/models/EmailField.dart';
import 'package:weather_weather/models/PasswordField.dart';
import 'package:weather_weather/models/LogRegButton.dart';
import 'package:weather_weather/models/GoogleLogRegButton.dart';
import 'package:weather_weather/services/StorageServices.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen>{
  StorageService storageService = StorageService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to WeatherWeather!',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              "Let's get started by logging you in our app.",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50.0),
            EmailField(controller: emailController),
            SizedBox(height: 16.0),
            PasswordField(controller: passwordController),
            SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {
                    // Handle checkbox change
                  },
                ),
                Text('Remember password', style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 16.0),
            LogRegButton(
              text: 'Login',
              onPressed: () {
                // Handle login button press
                loginUser(
                    context,
                    emailController.value.text,
                    passwordController.value.text);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle forgot password press
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  child: Text('Forgot password ?'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                  child: Text('Create new Account'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Or',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            GoogleLogRegButton(
              onPressed: () {
                // Handle Google sign-in button press
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'By signing in you are agreeing our Terms and Privacy Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  loginUser(context, String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      var item = StorageItem("uid", credential.user?.uid ?? "");

      await storageService.saveData(item);

      Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      print("Login Successful!");
    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
