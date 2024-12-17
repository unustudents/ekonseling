import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/sign_button.dart';
import '../widgets/sign_textformfield.dart';
import 'login_screen.dart';
import 'welcome_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Form(
                key: context.read<AuthBloc>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TEXT -- HALO
                    const Text(
                      "Halo! Daftar untuk Memulai",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // FORM INPUT -- NAMA LENGKAP
                    SignTextField(
                      label: 'Nama Lengkap',
                      hintText: 'Masukkan nama lengkap',
                      validator: (value) => context.read<AuthBloc>().validateName(value),
                      onChanged: (value) => context.read<AuthBloc>().add(NameChanged(name: value)),
                    ),
                    const SizedBox(height: 20),

                    // FORM INPUT -- NIS
                    SignTextField(
                      label: 'Nomor Induk Siswa',
                      hintText: 'Masukkan NIS',
                      validator: (value) => context.read<AuthBloc>().validateNIS(value),
                      onChanged: (value) => context.read<AuthBloc>().add(NIMChanged(nim: value)),
                    ),
                    const SizedBox(height: 20),

                    // FORM INPUT -- EMAIL
                    SignTextField(
                      label: 'Email',
                      hintText: 'Masukkan email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => context.read<AuthBloc>().validateEmail(value),
                      onChanged: (value) => context.read<AuthBloc>().add(EmailChanged(email: value)),
                    ),
                    const SizedBox(height: 20),

                    // FORM INPUT -- PASSWORD
                    SignTextField(
                      label: 'Kata Sandi',
                      hintText: 'Masukkan kata sandi',
                      obscureText: true,
                      validator: (value) => context.read<AuthBloc>().validatePassword(value),
                      onChanged: (value) => context.read<AuthBloc>().add(PasswordChanged(password: value)),
                    ),
                    const SizedBox(height: 20),

                    // FORM INPUT -- CONFIRM PASSWORD
                    SignTextField(
                      label: 'Konfirmasi Kata Sandi',
                      hintText: 'Masukkan ulang kata sandi',
                      obscureText: true,
                      validator: (value) => context.read<AuthBloc>().validateConfirmPassword(
                            value,
                            state.password,
                          ),
                      onChanged: (value) => context.read<AuthBloc>().add(ConfirmPasswordChanged(confirmPassword: value)),
                    ),
                    const SizedBox(height: 32),

                    // BUTTON -- DAFTAR
                    SignButton(
                      text: 'Daftar',
                      backgroundColor: Color(0xFF724778),
                      textColor: Colors.white,
                      onPressed: () {
                        if (context.read<AuthBloc>().formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(SubmitRegistration());
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    // TEXT -- SUDAH PUNYA AKUN
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text.rich(
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
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
