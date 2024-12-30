import 'package:flutter/material.dart';

import '../../../../supabase_config.dart';
import 'ganti_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var enabled = ValueNotifier<bool>(false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profil"),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
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
          ValueListenableBuilder(
            valueListenable: enabled,
            builder: (context, value, _) => TextFormField(
              decoration: InputDecoration(
                enabled: value,
                hintText: "Xi La",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // NOMOR INDUK SISWA
          const Text(
            "Nomor Induk Siswa",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder(
            valueListenable: enabled,
            builder: (context, value, _) => TextFormField(
              decoration: InputDecoration(
                enabled: value,
                hintText: "202231000",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // EMAIL
          const Text(
            "Email",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder<bool>(
            valueListenable: enabled,
            builder: (context, value, _) => TextFormField(
              decoration: InputDecoration(
                enabled: value,
                hintText: "xila@gmail.com",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),

          // GANTI KATA SANDI
          ValueListenableBuilder(
            valueListenable: enabled,
            builder: (context, value, _) => value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const GantiPasswordScreen()),
                          );
                        },
                        child: const Text(
                          "Ganti Kata Sandi",
                          style: TextStyle(color: Color(0xFF64558E), fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
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
            onPressed: () => enabled.value = !enabled.value,
            child: ValueListenableBuilder(
              valueListenable: enabled,
              builder: (context, value, _) {
                return Text(
                  value ? 'Simpan' : 'Edit Profil',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // TOMBOL - KELUAR
          ValueListenableBuilder<bool>(
            valueListenable: enabled,
            builder: (BuildContext context, bool value, Widget? child) {
              return OutlinedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  if (value) enabled.value = false;
                  if (!value) {
                    try {
                      await SupabaseConfig.client.auth.signOut();
                    } catch (e) {
                      print('error signout = $e');
                    }
                    // WidgetsBinding.instance.addPostFrameCallback((_) => context.goNamed(Routes.welcome));
                  }
                  value ? enabled.value = false : SupabaseConfig.client.auth.signOut();
                },
                child: Text(
                  value ? 'Batal' : 'Keluar',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
