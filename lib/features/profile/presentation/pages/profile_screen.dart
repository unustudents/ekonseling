import 'package:flutter/material.dart';

import '../../../../routes/app_pages.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nisController = TextEditingController();
  final _toggleEdit = ValueNotifier(false);

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _nameController.dispose();
    _nisController.dispose();
    _toggleEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final isEditMode = state.isEditMode;
        final data = state.data;

        if (state.isLoading) return const Center(child: Text('Memuat data ...'));
        if (state.error.isNotEmpty) return Center(child: Text(state.error));
        if (data.isEmpty) return const Center(child: Text('Data tidak ditemukan'));

        return ValueListenableBuilder(
          valueListenable: _toggleEdit,
          builder: (context, value, child) => ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 50),
              // FOTO PROFIL
              // CircleAvatar(
              //   backgroundColor: Colors.transparent,
              //   radius: 50,
              //   child: Image.asset("assets/images/user.png"),
              // ),
              Text.rich(
                TextSpan(
                  text: 'Academic - ',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.07, // Responsif berdasarkan lebar layar
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Fun',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // NAMA LENGKAP
              const Text(
                "Nama Lengkap",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController..text = data['name'] ?? "",
                decoration: InputDecoration(
                  enabled: value,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 15),

              // NOMOR INDUK SISWA
              const Text(
                "Nomor Induk Siswa",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nisController..text = data['nis'] ?? "",
                decoration: InputDecoration(
                  enabled: value,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 30),

              // GANTI KATA SANDI
              GestureDetector(
                onTap: () => context.pushNamed(Routes.changePassword),
                child: const Text(
                  "Ganti Kata Sandi",
                  style: TextStyle(color: Color(0xFF64558E), fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),

              // TOMBOL - EDIT PROFIL
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xFF64558E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (!value) _toggleEdit.value = !value;
                  if (isEditMode) {
                    context.read<ProfileBloc>().add(EditProfileEvent({
                          'name': _nameController.text,
                          'nis': _nisController.text,
                        }));
                  }
                },
                child: Text(
                  value ? 'Simpan' : 'Edit Profil',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),

              // TOMBOL - KELUAR
              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  if (value) _toggleEdit.value = !value;
                  if (!value) context.read<ProfileBloc>().add(SignOutRequestedEvent());
                },
                child: Text(
                  value ? 'Batal' : 'Keluar',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
