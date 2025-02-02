import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/snackbar.dart';
import '../cubit/ganti_password_cubit.dart';

class GantiPasswordScreen extends StatefulWidget {
  const GantiPasswordScreen({super.key});

  @override
  State<GantiPasswordScreen> createState() => _GantiPasswordScreenState();
}

class _GantiPasswordScreenState extends State<GantiPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = List.generate(3, (_) => TextEditingController());
  final _obsecure = List.generate(3, (_) => ValueNotifier(true));
  final _title = ['Kata Sandi Sekarang', 'Kata Sandi Baru', 'Konfirmasi Kata Sandi Baru'];

  @override
  void dispose() {
    for (var controller in _controller) {
      controller.dispose();
    }
    for (var notifier in _obsecure) {
      notifier.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ganti Kata Sandi")),
      body: BlocProvider(
        create: (context) => GantiPasswordCubit(),
        child: BlocConsumer<GantiPasswordCubit, GantiPasswordState>(
          listener: (context, state) {
            if (state.status == GantiPasswordStatus.loading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Center(child: LoadingAnimationWidget.progressiveDots(color: Colors.white, size: 60)),
              );
            } else {
              if (Navigator.canPop(context)) Navigator.pop(context);
              if (state.status == GantiPasswordStatus.failure) {
                AppSnackbar.show(context, msg: state.msg, status: Status.error);
                return;
              }
              if (state.status == GantiPasswordStatus.success) {
                AppSnackbar.show(context, msg: state.msg, status: Status.success);
                return;
              }
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  spacing: 20,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder(
                          valueListenable: _obsecure[index],
                          builder: (context, value, child) {
                            return TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: _controller[index],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText: _title[index],
                                suffixIcon: InkWell(
                                  onTap: () => _obsecure[index].value = !value,
                                  child: Icon(value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                                ),
                              ),
                              obscureText: value,
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Kata sandi tidak boleh kosong';
                                if (value.length < 6) return 'Kata sandi minimal 6 karakter';
                                if (index == 1 && value == _controller[0].text) return 'Kata sandi tidak boleh sama dengan sebelumnya';
                                if (index == 2 && value != _controller[1].text) return 'Kata sandi tidak sama';
                                return null;
                              },
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 20),
                      itemCount: _controller.length,
                    ),
                    // TOMBOL SIMPAN
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: const Color(0xFF64558E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<GantiPasswordCubit>().onUpdatePassword(
                                  currentPassword: _controller[0].text,
                                  newPassword: _controller[1].text,
                                );
                          }
                        },
                        child: const Text(
                          'Simpan',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                    // TOMBOL - KELUAR
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
