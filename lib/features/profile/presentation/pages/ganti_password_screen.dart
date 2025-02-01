import 'package:flutter/material.dart';

import '../../../../core/snackbar.dart';
import '../bloc/profile_bloc.dart';

class GantiPasswordScreen extends StatefulWidget {
  const GantiPasswordScreen({super.key});

  @override
  State<GantiPasswordScreen> createState() => _GantiPasswordScreenState();
}

class _GantiPasswordScreenState extends State<GantiPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _obsecureCurrent = ValueNotifier(true);
  final _obsecureNew = ValueNotifier(true);
  final _obsecureConfirm = ValueNotifier(true);

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    _obsecureCurrent.dispose();
    _obsecureNew.dispose();
    _obsecureConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganti Kata Sandi")),
      body: BlocProvider(
        create: (context) => ProfileBloc(),
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.errorForSnackbar.isNotEmpty) AppSnackbar.show(context, message: state.errorForSnackbar, isError: true);
            if (state.successChangePassword.isNotEmpty) AppSnackbar.show(context, message: state.successChangePassword, isSuccess: true);
          },
          builder: (context, state) {
            if (state.isLoading) Center(child: Text("Memperbarui password ..."));

            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 20),

                  // KATA SANDI LAMA
                  const Text(
                    "Kata Sandi Sekarang",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                    valueListenable: _obsecureCurrent,
                    builder: (context, value, child) => TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _currentPassController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        suffixIcon: InkWell(
                          onTap: () => _obsecureCurrent.value = !value,
                          child: Icon(value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        ),
                      ),
                      obscureText: value,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Kata sandi tidak boleh kosong';
                        if (value.length < 6) return 'Kata sandi minimal 6 karakter';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),

                  // KATA SANDI BARU
                  const Text(
                    "Kata Sandi Baru",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                    valueListenable: _obsecureNew,
                    builder: (context, value, child) => TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _newPassController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        suffixIcon: InkWell(
                          onTap: () => _obsecureNew.value = !value,
                          child: Icon(value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        ),
                      ),
                      obscureText: value,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Kata sandi tidak boleh kosong';
                        if (value.length < 6) return 'Kata sandi minimal 6 karakter';
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 15),

                  // KONFIRMASI KATA SANDI BARU
                  const Text(
                    "Konfirmasi Kata Sandi Baru",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ValueListenableBuilder(
                    valueListenable: _obsecureConfirm,
                    builder: (context, value, child) => TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _confirmPassController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        suffixIcon: InkWell(
                          onTap: () => _obsecureConfirm.value = !value,
                          child: Icon(value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        ),
                      ),
                      obscureText: value,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Kata sandi tidak boleh kosong';
                        if (value.length < 6) return 'Kata sandi minimal 6 karakter';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // TOMBOL SIMPAN
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF64558E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileBloc>().add(
                              ChangePasswordEvent(
                                oldPassword: _currentPassController.text,
                                newPassword: _newPassController.text,
                                confirmPassword: _confirmPassController.text,
                              ),
                            );
                      }
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // TOMBOL - KELUAR
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Batal',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
