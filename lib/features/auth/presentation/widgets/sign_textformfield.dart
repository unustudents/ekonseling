import 'package:flutter/material.dart';

class SignTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const SignTextField({
    super.key,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.onChanged,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF7F8F9),
        enabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        border: outlineInputBorder,
        labelText: label,
        hintText: hintText,
        labelStyle: hintAndLabelStyle,
        hintStyle: hintAndLabelStyle,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
);

TextStyle hintAndLabelStyle = TextStyle(
  color: Color(0xFF8391A1),
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
