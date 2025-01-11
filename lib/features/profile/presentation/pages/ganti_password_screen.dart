import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganti Kata Sandi")),
      body: BlocProvider(
        create: (context) => ProfileBloc(),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
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
                  TextFormField(
                    controller: _currentPassController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: InkWell(
                          onTap: () => context.read<ProfileBloc>().add(TogglePasswordVisibilityEvent(showPassword: 1)),
                          child: Icon(state.showCurrentPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined)),
                    ),
                    obscureText: state.showCurrentPassword,
                  ),
                  const SizedBox(height: 15),

                  // KATA SANDI BARU
                  const Text(
                    "Kata Sandi Baru",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _newPassController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: InkWell(
                          onTap: () => context.read<ProfileBloc>().add(TogglePasswordVisibilityEvent(showPassword: 2)),
                          child: Icon(state.showNewPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined)),
                    ),
                    obscureText: state.showNewPassword,
                  ),

                  const SizedBox(height: 15),

                  // KONFIRMASI KATA SANDI BARU
                  const Text(
                    "Konfirmasi Kata Sandi Baru",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _confirmPassController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      suffixIcon: InkWell(
                          onTap: () => context.read<ProfileBloc>().add(TogglePasswordVisibilityEvent(showPassword: 3)),
                          child: Icon(state.showConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined)),
                    ),
                    obscureText: state.showConfirmPassword,
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
                    onPressed: () {},
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
                    onPressed: () {},
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
