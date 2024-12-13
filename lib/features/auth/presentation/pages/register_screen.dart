import 'package:flutter/material.dart';

import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('Daftar')),
    //   body: Center(
    //     child: ListView(
    //       shrinkWrap: true,
    //       children: [
    //         SvgPicture.asset(
    //           'assets/images/undraw_welcoming.svg',
    //           height: MediaQuery.of(context).size.height * 0.3,
    //         ),
    //         const SizedBox(height: 25),
    //         const Padding(
    //           padding: EdgeInsets.all(30.0),
    //           child: Text(
    //             "Silahkan Masuk untuk membantu mengatasi masalah anda dengan berkonsultasi dengan Kami",
    //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //         const SizedBox(height: 25),
    //         Column(
    //           children: [
    //             Container(
    //               padding: const EdgeInsets.symmetric(horizontal: 20),
    //               width: double.tryParse("400"),
    //               child: FilledButton.icon(
    //                 icon: Image.asset("assets/images/google.png", width: 15),
    //                 label: const Text("Daftar Menggunakan Google", style: TextStyle(fontWeight: FontWeight.bold)),
    //                 onPressed: () {},
    //                 style: ButtonStyle(
    //                   backgroundColor: const WidgetStatePropertyAll(Colors.white),
    //                   elevation: const WidgetStatePropertyAll(1),
    //                   foregroundColor: const WidgetStatePropertyAll(Colors.black),
    //                   padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 22)),
    //                   shape: WidgetStatePropertyAll(
    //                     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             TextButton(
    //               onPressed: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => const LoginScreen()),
    //                 );
    //               },
    //               child: const Text("Sudah punya Akun? Masuk"),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
        child: Column(
          children: [
            // TOMBOL BACK
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: IconButton.outlined(
            //     onPressed: () {
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            //         (Route<dynamic> route) => false,
            //       );
            //     },
            //     icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            //     style: IconButton.styleFrom(
            //       side: const BorderSide(color: Color(0xFFE8ECF4)),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15), // Sudut melengkung sesuai gambar
            //       ),
            //       padding: const EdgeInsets.all(10), // Ukuran padding ikon
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 28),

            // TEKS SELAMAT DATANG
            const Text(
              "Halo ! Daftar Untuk Memulai",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            // FORM NAMA LENGKAP
            SizedBox(
              // width: 320,
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
                  labelText: 'Nama Lengkap',
                  labelStyle: const TextStyle(color: Color(0xFF8391A1), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // FORM NIM
            SizedBox(
              // width: 320,
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
                  labelText: 'Nomor Induk Mahasiswa',
                  labelStyle: const TextStyle(color: Color(0xFF8391A1), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // FORM EMAIL
            SizedBox(
              // width: 320,
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

            // FORM PASSWORD
            SizedBox(
              // width: 320,
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
                  labelText: 'Kata Sandi',
                  labelStyle: const TextStyle(color: Color(0xFF8391A1), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // FORM KONFIRM PASSWORD
            SizedBox(
              // width: 320,
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
                  labelText: 'Konfirmasi Kata Sandi',
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

            // ATAU
            // const Text("Atau"),
            // const SizedBox(height: 15),

            // TOMBOL GOOGLE
            // OutlinedButton.icon(
            //   icon: Image.asset("assets/images/google.png", width: 15),
            //   label: const Text("Daftar Menggunakan Google", style: TextStyle(fontWeight: FontWeight.bold)),
            //   onPressed: () {},
            //   style: OutlinedButton.styleFrom(
            //     foregroundColor: Colors.black,
            //     side: const BorderSide(color: Color(0xFFE8ECF4)),
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            //   ),
            // ),
            // const SizedBox(height: 20),

            // TOMBOL MASUK
            const Text.rich(
              TextSpan(
                text: 'Sudah punya Akun? ',
                style: TextStyle(color: Color(0xFF8391A1), fontSize: 14, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                    text: 'Masuk',
                    style: TextStyle(color: Color(0xFF724778)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
