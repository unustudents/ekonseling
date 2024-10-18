import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar')),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            SvgPicture.asset(
              'assets/images/undraw_welcoming.svg',
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                "Silahkan Masuk untuk membantu mengatasi masalah anda dengan berkonsultasi dengan Kami",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.tryParse("400"),
                  child: FilledButton.icon(
                    icon: Image.asset("assets/images/google.png", width: 15),
                    label: const Text("Daftar Menggunakan Google", style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(Colors.white),
                      elevation: const WidgetStatePropertyAll(1),
                      foregroundColor: const WidgetStatePropertyAll(Colors.black),
                      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 22)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text("Sudah punya Akun? Masuk"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
