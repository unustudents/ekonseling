import 'package:ekonseling/core/snackbar.dart';
import 'package:flutter/material.dart';

import '../bloc/task_bloc.dart';

class DetailTaskScreen extends StatelessWidget {
  final Map<String, dynamic> taskId;

  const DetailTaskScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    // context.read<TaskBloc>().add(LoadQuestionsEvent(weekId: taskId));
    print(taskId);
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        state.isAlert.isNotEmpty ? AppSnackbar.show(context, message: state.isAlert) : null;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Tugas Minggu ${taskId['week']}")),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            Text(
              'Silahkan di unduh soal dibawah ini !',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color(0xFF64558E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (taskId['soal'].isEmpty || taskId['soal'] == null) {
                  return AppSnackbar.show(context, message: 'Belum ada soal yang diunggah');
                } else {
                  context.read<TaskBloc>().add(DownloadSoalEvent(url: taskId['soal'], week: taskId['week'].toString()));
                }
              },
              child: Text(
                'Klik untuk unduh soal',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Kerjakan soal yang anda unduh sesuai intruksi yang tertera pada soal tersebut !',
              style: const TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color(0xFF64558E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {},
              child: Text(
                'Upload jawaban',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               for (int i = 1; i <= 15; i++)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Pertanyaan $i',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       TextField(
//                         maxLines: 3,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Jawaban...',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               SizedBox(height: 16),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: false,
//                     onChanged: (bool? value) {
//                       // Handle checkbox state change
//                     },
//                   ),
//                   Text('Saya menyadari bahwa jawaban yang saya berikan adalah benar.'),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle submit action
//                   },
//                   child: Text('Selesai'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
