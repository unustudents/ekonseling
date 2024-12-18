import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/sign_button.dart';
import '../widgets/sign_textformfield.dart';
import 'forgot_screen.dart';
import 'register_screen.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Form(
                key: context.read<AuthBloc>().formKey,
                child: Column(
                  children: [
                    // TEKS SELAMAT DATANG
                    const Text(
                      "Selamat Datang, Senang Bertemu Anda !",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // FORM INPUT -- NIS
                    SignTextField(
                      label: 'Nomor Induk Siswa',
                      hintText: 'Masukkan NIS',
                      validator: (value) => context.read<AuthBloc>().validateNIS(value),
                      onChanged: (value) => context.read<AuthBloc>().add(NIMChanged(nim: value)),
                    ),
                    const SizedBox(height: 20),

                    // FORM INPUT -- KATA SANDI
                    SignTextField(
                      label: 'Kata Sandi',
                      hintText: 'Masukkan kata sandi',
                      obscureText: true,
                      validator: (value) => context.read<AuthBloc>().validatePassword(value),
                      onChanged: (value) => context.read<AuthBloc>().add(PasswordChanged(password: value)),
                    ),
                    const SizedBox(height: 5),

                    // TOMBOL LUPA KATA SANDI
                    SizedBox(
                      // width: 331,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          onPressed: () {
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //     content: Text("Lupa Password?"),
                            //   ),
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPassScreen()),
                            );
                          },
                          child: const Text("Lupa Kata Sandi?"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TOMBOL MASUK
                    SignButton(
                      text: 'Masuk',
                      backgroundColor: Color(0xFF724778),
                      textColor: Colors.white,
                      onPressed: () {
                        if (context.read<AuthBloc>().formKey.currentState!.validate()) {
                          // context.read<AuthBloc>().add(SubmitRegistration());
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const AppScreen()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // ATAU
                    const Text("Atau"),
                    const SizedBox(height: 15),

                    // TOMBOL GOOGLE
                    OutlinedButton.icon(
                      icon: Image.asset("assets/images/google.png", width: 15),
                      label: const Text("Daftar Menggunakan Google", style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Color(0xFFE8ECF4)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TOMBOL MASUK
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: 'Belum punya Akun? ',
                          style: TextStyle(color: Color(0xFF8391A1), fontSize: 14, fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                              text: 'Daftar',
                              style: TextStyle(color: Color(0xFF724778)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Expanded(child: Spacer()),
      ),
    );
  }
}
