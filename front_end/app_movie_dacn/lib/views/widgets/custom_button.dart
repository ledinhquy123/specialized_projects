import 'package:app_movie/constant/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  double? width;
  double? height;
  String? text;
  void Function()? onTap;
  TextStyle? style;

  CustomButton({
    super.key,
    this.width,
    this.height,
    this.text,
    this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ button1, button2 ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadiusDirectional.all(
            Radius.circular(30)
          ),
          border: Border.all(
            width: 1,
            color: outline
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(2, 1),
              color: button1
            )
          ]
        ),
        child: Text(
          text!,
          textAlign: TextAlign.center,
          style: style
        ),
      ),
    );
  }
}