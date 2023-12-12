import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF288CC5), // Set the custom color
        borderRadius: BorderRadius.circular(10.0), // Match the circular radius
      ),
      child: TextField(
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.white),
          suffixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF104084)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF104084)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
