import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const SignButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width * 0.9, // Lebar 90% dari layar
        padding: EdgeInsets.symmetric(vertical: size.height * 0.02), // Tinggi tombol responsif
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              // fontSize: size.width * 0.045, // Font responsif
            ),
          ),
        ),
      ),
    );
  }
}
