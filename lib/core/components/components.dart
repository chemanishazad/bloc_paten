import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message,
      {Color colors = Colors.black87}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        backgroundColor: colors,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
