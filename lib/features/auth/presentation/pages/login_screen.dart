import 'package:flutter/material.dart';

import '../../../../core/snackbar.dart';
import '../../../../routes/app_pages.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/sign_button.dart';
import '../widgets/sign_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // VARIABEL UNTUK MENAMPUNG INPUTAN NIS DAN PASSWORD
  final TextEditingController _nisCtrl = TextEditingController();

  final TextEditingController _passCtrl = TextEditingController();

  @override
  void dispose() {
    _nisCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MENGAMBIL BLOC DARI PROVIDER
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              // if (state is AuthSuccess) context.goNamed(Routes.home);
              if (state is AuthError) AppSnackbar.show(context, message: state.error.toString());
            },
            builder: (context, state) {
              // VARIABEL UNTUK MENAMPUNG BLOC
              final authBloc = context.read<AuthBloc>();

              return Form(
                key: context.read<AuthBloc>().formKey,
                child: Column(
                  children: [
                    // TEKS SELAMAT DATANG
                    const Text(
                      "Selamat Datang, Senang Bertemu Anda !",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),

                    // FORM INPUT -- NIS
                    SignTextField(
                      label: 'Nomor Induk Siswa',
                      hintText: 'Masukkan NIS',
                      controller: _nisCtrl,
                      validator: (value) => authBloc.validateNIS(value),
                      onChanged: (value) => authBloc.add(NIMChanged(nim: value)),
                    ),
                    const SizedBox(height: 20),

                    // FORM INPUT -- KATA SANDI
                    SignTextField(
                      label: 'Kata Sandi',
                      hintText: 'Masukkan kata sandi',
                      controller: _passCtrl,
                      obscureText: false,
                      validator: (value) => authBloc.validatePassword(value),
                      onChanged: (value) => authBloc.add(PasswordChanged(password: value)),
                    ),
                    const SizedBox(height: 5),

                    // TOMBOL LUPA KATA SANDI
                    SizedBox(
                      // width: 331,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: MaterialButton(
                          onPressed: () => context.pushNamed(Routes.forgotPassword),
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
                        if (authBloc.formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(SubmitSignIn(nis: _nisCtrl.text, password: _passCtrl.text));
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    // TOMBOL MASUK
                    TextButton(
                      onPressed: () => context.goNamed(Routes.register),
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
      ),
      // Expanded(child: Spacer()),
    );
  }
}
