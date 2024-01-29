import 'package:app_movie/constant/colors.dart';
import 'package:flutter/material.dart';

Widget showButtonBack(BuildContext context) {
  return Positioned(
    top: 64,
    left: 0,
    child: InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ primaryMain1, primaryMain2 ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(40)
          )
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    ),
  );
}