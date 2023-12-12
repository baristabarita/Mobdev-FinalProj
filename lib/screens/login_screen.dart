import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_weather/models/StorageItem.dart';
import 'package:weather_weather/screens/registration_screen.dart';
import 'package:weather_weather/screens/dashboard_screen.dart';
import 'package:weather_weather/widgets/EmailField.dart';
import 'package:weather_weather/widgets/PasswordField.dart';
import 'package:weather_weather/widgets/LogRegButton.dart';
import 'package:weather_weather/widgets/GoogleLogRegButton.dart';
import 'package:weather_weather/services/StorageServices.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StorageService storageService = StorageService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line to avoid bottom overflow
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF47BFDF), Color(0xFF4A91FF)],
            begin: Alignment(-0.21, -0.98),
            end: Alignment(0.21, 0.98),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'lib/icons/wind.png', // Make sure the path is correct
                height: 60.0, // Adjust the height as needed
                width: 60.0, // Adjust the width as needed
              ),
              SizedBox(height: 10.0),
              Text(
                'Welcome to WeatherWeather!',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                "Let's get started by logging you in our app.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
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
                  Text('Remember password',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(height: 16.0),
              LogRegButton(
                text: 'Login',
                onPressed: () {
                  // Handle login button press
                  loginUser(context, emailController.value.text,
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
                      foregroundColor: Colors.white,
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
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Create new Account'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              GoogleLogRegButton(
                onPressed: () {
                  // Handle Google sign-in button press
                  loginWithGoogle();
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'By signing in you are agreeing our Terms and Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginUser(context, String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Link Google provider if a Google user with the same email exists
      await _linkGoogleProvider(credential);

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

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential? userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Link email/password provider if an email/password user with the same email exists
      await _linkEmailPasswordProvider(userCredential);

      Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      print("Login with Google Successful!");
    } catch (e) {
      print(e);
    }
  }

// Function to link Google provider if a Google user with the same email exists
  _linkGoogleProvider(UserCredential emailPasswordCredential) async {
    try {
      if (emailPasswordCredential.user != null) {
        // Check if a Google user with the same email exists
        List<String> signInMethods = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(
                emailPasswordCredential.user!.email ?? '');

        // Check if the list contains 'google.com', which indicates a Google sign-in
        if (signInMethods.contains('google.com')) {
          // Get the Google sign-in credentials
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;

          // Create a GoogleAuthCredential with the id token and access token
          final googleCredential = GoogleAuthProvider.credential(
            idToken: googleAuth?.idToken,
            accessToken: googleAuth?.accessToken,
          );

          // Link Google provider
          await emailPasswordCredential.user!
              .linkWithCredential(googleCredential);
          print("Linked Google Provider!");
        }
      }
    } catch (e) {
      print("Error linking Google provider: $e");
    }
  }

// Function to link email/password provider if an email/password user with the same email exists
  _linkEmailPasswordProvider(UserCredential googleCredential) async {
    try {
      if (googleCredential.user != null) {
        // Check if an email/password user with the same email exists
        List<String> signInMethods = await FirebaseAuth.instance
            .fetchSignInMethodsForEmail(googleCredential.user!.email ?? '');

        // Check if the list contains 'password', which indicates an email/password sign-in
        if (signInMethods.contains('password')) {
          String password = '...';

          // Create an EmailAuthCredential with the email and password
          final emailPasswordCredential = EmailAuthProvider.credential(
            email: googleCredential.user!.email ?? '',
            password: password,
          );

          // Link email/password provider
          await googleCredential.user!
              .linkWithCredential(emailPasswordCredential);
          print("Linked Email/Password Provider!");
        }
      }
    } catch (e) {
      print("Error linking Email/Password provider: $e");
    }
  }
}
