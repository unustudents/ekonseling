import 'package:flutter/material.dart';

import '../../../../core/snackbar.dart';
import '../cubit/task_cubit.dart';

class DetailTaskScreen extends StatelessWidget {
  final Map<String, dynamic> taskId;

  const DetailTaskScreen({super.key, required this.taskId});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        state.isAlert.isNotEmpty ? AppSnackbar.show(context, message: state.isAlert) : null;
        if (state.successUpload.isNotEmpty) {
          AppSnackbar.show(context, message: state.successUpload);
          Navigator.pop(context);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: Text("Tugas Minggu ${taskId['week']}")),
        body: state.isPermission
            ? ListView(
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
                        state.fileExist && state.downloading == false ? context.read<TaskCubit>().onOpenFile() : context.read<TaskCubit>().onDownloadQuestion(url: '${taskId['soal']}');
                      }
                    },
                    child: Text(
                      state.downloading
                          ? 'Mendownload ... ${state.progress.toStringAsFixed(2)}%'
                          : state.fileExist
                              ? 'Buka soal'
                              : 'Klik untuk unduh soal',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Kerjakan soal yang anda unduh sesuai intruksi yang tertera pada soal tersebut !',
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  if (state.fileSelected.isNotEmpty) ...{
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'File yang akan diupload :',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        ...state.fileSelected.map(
                          (file) => ListTile(
                            title: Text(file.name),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<TaskCubit>().onRemoveFile(file);
                              },
                            ),
                          ),
                        ),
                        // for (var file in state.fileSelected)
                        TextButton.icon(
                            onPressed: () {
                              context.read<TaskCubit>().onSelectFile();
                            },
                            label: Text('Tambah File'),
                            icon: Icon(Icons.add)),
                        SizedBox(height: 10),
                      ],
                    ),
                  },
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF64558E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (state.fileSelected.isEmpty) {
                        context.read<TaskCubit>().onSelectFile();
                      } else {
                        context.read<TaskCubit>().onUploadTask(state.fileSelected);
                        // AppSnackbar.show(context, message: 'Kirim');
                      }
                    },
                    child: Text(
                      state.fileSelected.isEmpty ? 'Upload jawaban' : 'Kirim jawaban',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  // SizedBox(height: 20),
                ],
              )
            : TextButton(onPressed: () => context.read<TaskCubit>().onCheckPermission(), child: Center(child: Text('Ijinkan akses penyimpanan'))),
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
