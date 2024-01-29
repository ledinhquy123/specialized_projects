import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  bool obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  String? Function(String?)? validator;
  String? hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextStyle? hintStyle;
  bool? filled;
  Color? fillColor;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  TextStyle? style;
  void Function(String)? onChanged;
  InputBorder? errorBorder;
  TextStyle? errorStyle;
  InputBorder? focusedErrorBorder;

  CustomTextFormField({
    super.key,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.validator,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintStyle,
    this.filled,
    this.fillColor,
    this.enabledBorder,
    this.focusedBorder,
    this.style,
    this.onChanged,
    this.errorBorder,
    this.errorStyle,
    this.focusedErrorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      style: style,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor: fillColor,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        errorStyle: errorStyle,
        focusedErrorBorder: focusedErrorBorder
      ),
    );
  }
}