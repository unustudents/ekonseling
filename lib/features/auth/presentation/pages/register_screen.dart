import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routes/app_pages.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/sign_button.dart';
import '../widgets/sign_textformfield.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController nisCtrl = TextEditingController();
    final TextEditingController passCtrl = TextEditingController();
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.goNamed(Routes.welcome),
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
                      controller: nameCtrl,
                      hintText: 'Masukkan nama lengkap',
                      validator: (value) => context.read<AuthBloc>().validateName(value),
                      onChanged: (value) => context.read<AuthBloc>().add(NameChanged(name: value)),
                    ),
                    const SizedBox(height: 20),

                    // FORM INPUT -- NIS
                    SignTextField(
                      label: 'Nomor Induk Siswa',
                      controller: nisCtrl,
                      hintText: 'Masukkan NIS',
                      validator: (value) => context.read<AuthBloc>().validateNIS(value),
                      onChanged: (value) => context.read<AuthBloc>().add(NIMChanged(nim: value)),
                    ),
                    const SizedBox(height: 20),

                    // FORM INPUT -- EMAIL
                    // SignTextField(
                    //   label: 'Email',
                    //   hintText: 'Masukkan email',
                    //   keyboardType: TextInputType.emailAddress,
                    //   validator: (value) => context.read<AuthBloc>().validateEmail(value),
                    //   onChanged: (value) => context.read<AuthBloc>().add(EmailChanged(email: value)),
                    // ),
                    // const SizedBox(height: 20),

                    // FORM INPUT -- PASSWORD
                    SignTextField(
                      label: 'Kata Sandi',
                      controller: passCtrl,
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
                          context.read<AuthBloc>().add(SubmitRegistration(name: nameCtrl.text, nis: nisCtrl.text, password: passCtrl.text));
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    // TEXT -- SUDAH PUNYA AKUN
                    Center(
                      child: TextButton(
                        onPressed: () => context.goNamed(Routes.login),
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
