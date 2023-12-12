import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.grey),
        suffixIcon: Icon(
          Icons.lock,
          color: Colors.grey[400],
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
