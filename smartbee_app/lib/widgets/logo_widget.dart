import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
      ),
      child: Center(
        child: Opacity(
          opacity: 0.8, // Transparansi 80%
          child: Image.asset(
            'assets/images/LOGO.png',
            width: size * 1.0,
            height: size * 1.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
