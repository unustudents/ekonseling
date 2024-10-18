import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Masuk")),
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
                    label: const Text("Masuk Menggunakan Google", style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Navigator.pop(context);
                  },
                  child: const Text("Belum punya Akun? Daftar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.all(22.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         IconButton.outlined(
    //           onPressed: () {
    //             // Fungsi ketika tombol ditekan
    //             // Navigator.of(context).pop();
    //           },
    //           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
    //           style: IconButton.styleFrom(
    //             side: const BorderSide(color: Color(0xFFE8ECF4)),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(15), // Sudut melengkung sesuai gambar
    //             ),
    //             padding: const EdgeInsets.all(10), // Ukuran padding ikon
    //           ),
    //         ),
    //         const SizedBox(height: 28),
    //         const Text(
    //           "Selamat Datang, Senang Bertemu Anda !",
    //           style: TextStyle(
    //             fontSize: 30,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         const SizedBox(height: 32),
    //         TextFormField(
    //           decoration: InputDecoration(
    //             fillColor: const Color(0xFFF7F8F9),
    //             enabledBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(8),
    //               borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(8),
    //               borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
    //             ),
    //             // floatingLabelBehavior: FloatingLabelBehavior.never,
    //             // hintText: 'Masukkan Nomor Induk Mahasiswa Anda',
    //             labelText: 'Nomor Induk Mahasiswa',
    //             labelStyle: const TextStyle(color: Color(0xFF8391A1), fontSize: 14, fontWeight: FontWeight.w500),
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         TextFormField(
    //           decoration: InputDecoration(
    //             fillColor: const Color(0xFFF7F8F9),
    //             enabledBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(8),
    //               borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
    //             ),
    //             focusedBorder: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(8),
    //               borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
    //             ),
    //             labelText: 'Kata Sandi',
    //             labelStyle: const TextStyle(color: Color(0xFF8391A1), fontSize: 14, fontWeight: FontWeight.w500),
    //             suffixIcon: const Icon(Icons.visibility_rounded),
    //             suffixIconColor: Color(0xFF6A707C),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}


// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             // Implement your navigation back action here
//           },
//         ),
//         title: Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Selamat Datang kembali! Senang bertemu Anda lagi!',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Masukkan Nomor Induk Mahasiswa Anda',
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Masukkan Password Anda',
//                 suffixIcon: Icon(Icons.visibility_off),
//               ),
//             ),
//             SizedBox(height: 8),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {
//                   // Implement your password reset action here
//                 },
//                 child: Text('Lupa Password?'),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement your login action here
//               },
//               child: Text('Masuk'),
//             ),
//             SizedBox(height: 16),
//             Text('Atau'),
//             SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: () {
//                 // Implement your Google login action here
//               },
              