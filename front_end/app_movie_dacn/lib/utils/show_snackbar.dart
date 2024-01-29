import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text, Color color) {
  final snackBar = SnackBar(
    backgroundColor: color,
    content: Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w700,
        color: Colors.white
      )
    )
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}