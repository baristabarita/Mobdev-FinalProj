import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent, // Transparent background
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white), // White text color
        decoration: InputDecoration(
          labelText: 'Email Address',
          labelStyle: TextStyle(color: Colors.white),
          suffixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // White border on focus
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // White border when not focused
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
