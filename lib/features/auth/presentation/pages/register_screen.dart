import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar')),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/undraw_welcoming.svg',
              fit: BoxFit.cover,
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // width: double.infinity,
              width: double.tryParse("400"),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  // maximumSize: const Size.fromWidth(400),
                  elevation: 0.2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(vertical: 22),
                ),
                onPressed: () {
                  // Add your button press action here
                },
                icon: Image.asset("assets/images/google.png", width: 15),
                label: const Text(
                  'Daftar Menggunakan Google',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text("Sudah punya Akun? Masuk"),
            ),
          ],
        ),
      ),
    );
  }
}
