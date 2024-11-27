import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            SvgPicture.asset(
              'assets/images/undraw_welcoming.svg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const SizedBox(height: 71),
            const Text.rich(
              TextSpan(
                text: 'E - ',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'Konseling',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 37),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF724778),
                foregroundColor: Colors.white,
                minimumSize: const Size(331, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                // padding: const EdgeInsets.symmetric(vertical: 22),
              ),
              onPressed: () {
                // Add your button press action here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Masuk', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1E232C),
                minimumSize: const Size(331, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: Color(0xFF1E232C), width: 0.1)),
                // padding: const EdgeInsets.symmetric(vertical: 22),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Daftar', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
