import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_weather/models/EmailField.dart';
import 'package:weather_weather/models/PasswordField.dart';
import 'package:weather_weather/models/LogRegButton.dart';
import 'package:weather_weather/models/GoogleLogRegButton.dart';
import 'package:weather_weather/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = "/register";
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegisterState();
}
class _RegisterState extends State<RegistrationScreen>{
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
              'Create a New Account',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              "Sign up to WeatherWeather to get started.",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.0),
            EmailField(controller: emailController),
            SizedBox(height: 16.0),
            PasswordField(controller: passwordController),
            SizedBox(height: 16.0),
            LogRegButton(
              text: 'Register',
              onPressed: () {
                //handler function to register new user
                registerUser(
                    context,
                    emailController.value.text, 
                    passwordController.value.text);
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                  },
                  child: Text(
                    "Login here",
                    style: TextStyle(color: Colors.blueAccent),
                  )
                )
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
                // Handle Google sign-up button press
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'By signing up, you are agreeing our Terms and Privacy Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  registerUser(context, String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);

      print("Successful registration! you can login now");

    } on FirebaseAuthException catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
