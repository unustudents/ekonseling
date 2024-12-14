import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/welcome_button.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Spacer untuk memberikan jarak responsif
            Spacer(flex: 2),
            SvgPicture.asset(
              'assets/images/undraw_welcoming.svg',
              fit: BoxFit.contain,
              height: size.height * 0.3,
            ),
            Spacer(flex: 1),
            Text.rich(
              TextSpan(
                text: 'E - ',
                style: TextStyle(
                  fontSize: size.width * 0.06, // Responsif berdasarkan lebar layar
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Konseling',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.04),

            // Tombol Masuk
            WelcomeButton(
              text: 'Masuk',
              backgroundColor: const Color(0xFF724778),
              textColor: Colors.white,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ),
            ),
            SizedBox(height: size.height * 0.02),

            // Tombol Daftar
            WelcomeButton(
              text: 'Daftar',
              backgroundColor: Colors.white,
              textColor: const Color(0xFF1E232C),
              borderColor: const Color(0xFF1E232C),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
