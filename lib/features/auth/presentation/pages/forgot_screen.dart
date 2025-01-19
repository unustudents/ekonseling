import 'package:flutter/material.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TEKS LUPA KATA SANDI
            const Text(
              "Lupa Kata Sandi ?",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            // TEKS SAMBUTAN
            const Text(
              "Jangan khawatir itu terjadi. Silahkan masukkan alamat email yang terdaftar di akun anda.",
              textAlign: TextAlign.justify,
              style: TextStyle(color: Color(0xFF8391A1), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),

            // FORM EMAIL
            SizedBox(
              width: 320,
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF7F8F9),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Color(0xFF8391A1), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TOMBOL MASUK
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF724778),
                foregroundColor: Colors.white,
                minimumSize: const Size(331, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {},
              child: const Text('Kirim Kode', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
