import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tugas")),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: 30,
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey.shade300)),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF64558E),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                'Tugas Minggu ke ${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: const Text('Isi tugas anda dan akan kami review'),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}
