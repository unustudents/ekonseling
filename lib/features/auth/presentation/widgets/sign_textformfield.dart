import 'package:flutter/material.dart';

class SignTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const SignTextField({
    super.key,
    required this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF7F8F9),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
        ),
        labelText: label,
        hintText: hintText,
        labelStyle: const TextStyle(
          color: Color(0xFF8391A1),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
