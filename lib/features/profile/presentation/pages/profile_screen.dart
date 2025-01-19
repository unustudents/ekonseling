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

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _nameController.dispose();
    _nisController.dispose();
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

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 50),
            // FOTO PROFIL
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              child: Image.asset("assets/images/google.png"),
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
                enabled: isEditMode,
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
                enabled: isEditMode,
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

            // if (isEditMode) ...[
            //   const SizedBox(height: 12),
            //   TextFormField(
            //     decoration: InputDecoration(
            //       hintText: "********",
            //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            //     ),
            //   ),
            //   const SizedBox(height: 15),
            // ],
            // ValueListenableBuilder(
            //   valueListenable: enabled,
            //   builder: (context, value, _) => value
            //       ? Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             const SizedBox(height: 15),
            //             InkWell(
            //               onTap: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(builder: (context) => const GantiPasswordScreen()),
            //                 );
            //               },
            //               child: const Text(
            //                 "Ganti Kata Sandi",
            //                 style: TextStyle(color: Color(0xFF64558E), fontWeight: FontWeight.w600),
            //               ),
            //             ),
            //           ],
            //         )
            //       : const SizedBox.shrink(),
            // ),

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
                if (!isEditMode) context.read<ProfileBloc>().add(ToggleEditModeEvent());
                if (isEditMode) {
                  context.read<ProfileBloc>().add(EditProfileEvent({
                        'name': _nameController.text,
                        'nis': _nisController.text,
                      }));
                }
              },
              child: Text(
                isEditMode ? 'Simpan' : 'Edit Profil',
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
                if (isEditMode) context.read<ProfileBloc>().add(ToggleEditModeEvent());
                if (!isEditMode) context.read<ProfileBloc>().add(SignOutRequestedEvent());
              },
              child: Text(
                isEditMode ? 'Batal' : 'Keluar',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
