import 'package:flutter/material.dart';

class GoogleLogRegButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLogRegButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/icons/google_icon.png', // Make sure to provide the correct path
            height: 15.0,
            width: 15.0,
          ),
          SizedBox(width: 8.0),
          Text('Sign In with Google'),
        ],
      ),
    );
  }
}
