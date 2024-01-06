import 'package:flutter/material.dart';

class LogRegButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LogRegButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 124, 196, 255),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.blue.withOpacity(0.5),
        elevation: 8.0,
      ),
      child: Text(text),
    );
  }
}
