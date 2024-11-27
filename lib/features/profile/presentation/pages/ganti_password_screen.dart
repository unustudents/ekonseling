import 'package:flutter/material.dart';

class GantiPasswordScreen extends StatelessWidget {
  const GantiPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var enabled = ValueNotifier<bool>(true);

    return Scaffold(
      appBar: AppBar(title: const Text("Ganti Kata Sandi")),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),

          // KATA SANDI LAMA
          const Text(
            "Kata Sandi Lama",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder(
            valueListenable: enabled,
            builder: (BuildContext context, bool value, Widget? child) => TextFormField(
              decoration: InputDecoration(
                hintText: "Masukkan kata sandi lama",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: InkWell(
                    onTap: () => enabled.value = !enabled.value, child: Icon(value ? Icons.visibility_off_outlined : Icons.visibility_outlined)),
              ),
              obscureText: value,
            ),
          ),
          const SizedBox(height: 15),

          // KATA SANDI BARU
          const Text(
            "Kata Sandi Baru",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Masukkan kata sandi baru",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: const Icon(Icons.visibility_off_outlined),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 15),

          // KONFIRMASI KATA SANDI BARU
          const Text(
            "Konfirmasi Kata Sandi Baru",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Masukkan konfirmasi kata sandi baru",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: const Icon(Icons.visibility_off_outlined),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),

          // TOMBOL SIMPAN
          ValueListenableBuilder(
            valueListenable: enabled,
            builder: (BuildContext context, bool value, Widget? child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color(0xFF64558E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => enabled.value = !enabled.value,
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // TOMBOL - KELUAR
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => enabled.value = false,
            child: const Text(
              'Batal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
