import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/snackbar.dart';
import '../../../../routes/app_pages.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/sign_button.dart';
import '../widgets/sign_textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // VARIABEL UNTUK MENAMPUNG INPUTAN NIS DAN PASSWORD
  final _nisCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nisCtrl.dispose();
    _passCtrl.dispose();
    _formKey.currentState?.dispose();
    // Taruh ini di akhir untuk membersihkan sampah
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            // Menampilkan loading animation
            if (state.isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(child: LoadingAnimationWidget.progressiveDots(color: Colors.white, size: 60)),
              );
            } else {
              context.pop();
            }
            // Menampilkan pesan error jika ada
            if (state.error.isNotEmpty) AppSnackbar.show(context, message: state.error, isError: true);
            // Jika user sudah login, maka akan diarahkan ke halaman home
            if (state.isAuthenticated) context.goNamed(Routes.home);
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: kToolbarHeight * 2),
                  // TEKS SELAMAT DATANG
                  const Text(
                    "Selamat Datang, Senang Bertemu Anda !",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),

                  // FORM INPUT -- NIS
                  SignTextField(
                    label: 'Nomor Induk Siswa',
                    controller: _nisCtrl,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'NIS tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // FORM INPUT -- KATA SANDI
                  SignTextField(
                    label: 'Kata Sandi',
                    controller: _passCtrl,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // TOMBOL MASUK
                  SignButton(
                    text: 'Masuk',
                    backgroundColor: Color(0xFF724778),
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate() && state.isLoading == false) {
                        // context.read<AuthCubit>().add(SubmitSignIn(nis: _nisCtrl.text, password: _passCtrl.text));
                        context.read<AuthCubit>().onSubmitSignIn(password: _passCtrl.text, nis: _nisCtrl.text);
                      }
                    },
                  ),
                  const SizedBox(height: 25),

                  // TOMBOL DAFTAR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 3,
                    children: [
                      Text(
                        "Belum punya Akun ?",
                        style: TextStyle(color: Color(0xFF8391A1), fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () => context.goNamed(Routes.register),
                        child: Text(
                          " Daftar",
                          style: TextStyle(color: Color(0xFF724778), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
