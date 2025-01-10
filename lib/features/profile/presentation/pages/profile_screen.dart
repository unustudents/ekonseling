import 'package:flutter/material.dart';

import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final isEditMode = state.isEditMode;

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
              decoration: InputDecoration(
                enabled: isEditMode,
                hintText: "Xi La",
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
              decoration: InputDecoration(
                enabled: isEditMode,
                hintText: "202231000",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),

            // GANTI KATA SANDI
            // if (isEditMode) ...[
            //   const Text(
            //     "Kata Sandi",
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //   ),
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
                // enabled.value = !enabled.value;
                context.read<ProfileBloc>().add(ToggleEditModeEvent());
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
