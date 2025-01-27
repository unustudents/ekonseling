import 'package:flutter/material.dart';

import '../../../../core/snackbar.dart';
import '../../../../routes/app_pages.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/sign_button.dart';
import '../widgets/sign_textformfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _nisCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _passConfirmCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _nisCtrl.dispose();
    _passCtrl.dispose();
    _passConfirmCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.isSuccess) {
              // Jika berhasil mendaftar
              AppSnackbar.show(context, message: "Yeay, Berhasil Daftar. Saatnya Masuk !", isSuccess: true);
            }
            if (state.error.isNotEmpty) {
              // JIKA GAGAL LOGIN
              AppSnackbar.show(context, message: state.error.toString(), isError: true);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
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
                    controller: _nameCtrl,
                    // validator: (value) => context.read<AuthBloc>().validateName(value),
                  ),
                  const SizedBox(height: 20),

                  // FORM INPUT -- NIS
                  SignTextField(
                    label: 'Nomor Induk Siswa',
                    controller: _nisCtrl,
                    // validator: (value) => context.read<AuthBloc>().validateNIS(value),
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
                    controller: _passCtrl,
                    obscureText: false,
                    // validator: (value) => context.read<AuthBloc>().validatePassword(value),
                  ),
                  const SizedBox(height: 20),

                  // FORM INPUT -- CONFIRM PASSWORD
                  SignTextField(
                    label: 'Konfirmasi Kata Sandi',
                    controller: _passConfirmCtrl,
                    obscureText: false,
                    // validator: (value) => context.read<AuthBloc>().validateConfirmPassword(
                    //       value,
                    //       state.password,
                    //     ),
                  ),
                  const SizedBox(height: 32),

                  // BUTTON -- DAFTAR
                  SignButton(
                    text: 'Daftar',
                    backgroundColor: Color(0xFF724778),
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().onSubmitRegistration(name: _nameCtrl.text, nis: _nisCtrl.text, password: _passCtrl.text);
                        //  add(SubmitRegistration(name: _nameCtrl.text, nis: _nisCtrl.text, password: _passCtrl.text));
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
    );
  }
}
