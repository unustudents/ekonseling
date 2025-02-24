import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/snackbar.dart';
import '../../../../core/utils/validators.dart';
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
  final _controller = List.generate(4, (_) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  final _obsecurePasswd = ValueNotifier(true);
  final _obsecureConfirmPasswd = ValueNotifier(true);

  @override
  void dispose() {
    for (var controller in _controller) {
      controller.dispose();
    }
    _formKey.currentState?.dispose();
    _obsecurePasswd.dispose();
    _obsecureConfirmPasswd.dispose();
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
            if (state.status == AuthStatus.loading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(child: LoadingAnimationWidget.progressiveDots(color: Colors.white, size: 60)),
              );
            } else {
              if (context.canPop()) context.pop();
            }
            // Jika isSuccess, maka tampilkan snackbar
            if (state.status == AuthStatus.success) {
              AppSnackbar.show(context, msg: "Yeay, Berhasil Daftar. Saatnya Masuk !", status: Status.success);
              context.goNamed(Routes.login);
            }
            // Jika error, maka tampilkan snackbar
            if (state.error.isNotEmpty) AppSnackbar.show(context, msg: state.error.toString(), status: Status.error);
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
                    controller: _controller[0],
                    validator: (value) {
                      if (isValidEmpty(value)) return 'Nama tidak boleh kosong';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // FORM INPUT -- NIS
                  SignTextField(
                    label: 'Nomor Induk Siswa',
                    controller: _controller[1],
                    validator: (value) {
                      if (isValidEmpty(value)) return 'NIS tidak boleh kosong';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // FORM INPUT -- PASSWORD
                  ValueListenableBuilder(
                    valueListenable: _obsecurePasswd,
                    builder: (context, value, child) {
                      return SignTextField(
                        label: 'Kata Sandi',
                        controller: _controller[2],
                        obscureText: value,
                        suffixIcon: InkWell(
                          onTap: () => _obsecurePasswd.value = !value,
                          child: Icon(value ? Icons.visibility_off : Icons.visibility),
                        ),
                        validator: (value) {
                          if (isValidEmpty(value)) return 'Kata sandi tidak boleh kosong';
                          if (!isValidPassword(value!)) return 'Kata sandi minimal 6 karakter';
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // FORM INPUT -- CONFIRM PASSWORD
                  ValueListenableBuilder(
                    valueListenable: _obsecureConfirmPasswd,
                    builder: (context, value, child) => SignTextField(
                      label: 'Konfirmasi Kata Sandi',
                      controller: _controller[3],
                      obscureText: value,
                      suffixIcon: InkWell(
                        onTap: () => _obsecureConfirmPasswd.value = !value,
                        child: Icon(value ? Icons.visibility_off : Icons.visibility),
                      ),
                      validator: (value) {
                        if (isValidEmpty(value)) return 'Konfirmasi kata sandi tidak boleh kosong';
                        if (!isValidPassword(value!)) return 'Konfirmasi kata sandi minimal 6 karakter';
                        if (value != _controller[2].text) return 'Konfirmasi kata sandi tidak sesuai';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // BUTTON -- DAFTAR
                  SignButton(
                    text: 'Daftar',
                    backgroundColor: Color(0xFF724778),
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().onSubmitRegistration(name: _controller[0].text, nis: _controller[1].text, password: _controller[2].text);
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // TEXT -- SUDAH PUNYA AKUN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 3,
                    children: [
                      Text(
                        "Sudah punya Akun ?",
                        style: TextStyle(color: Color(0xFF8391A1), fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () => context.goNamed(Routes.login),
                        child: Text(
                          " Masuk",
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
