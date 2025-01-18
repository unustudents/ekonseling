import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ekonseling/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import '../../../../core/path_directory.dart';
import '../../../../core/permission.dart';
import '../../../../core/snackbar.dart';
import '../bloc/task_bloc.dart';

class DetailTaskScreen extends StatefulWidget {
  final Map<String, dynamic> taskId;

  const DetailTaskScreen({super.key, required this.taskId});

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  bool isPermission = false;
  var checkAllPermission = CheckPermission();

  checkPermission() async {
    var permission = await checkAllPermission.isStoragePermission();
    if (permission) {
      setState(() => isPermission = true);
    }
  }

  bool downloading = false;
  bool fileExist = false;
  double progress = 0;
  var getPathFile = PathDirectory();
  late String filePath;
  String fileName = '';
  CancelToken cancelToken = CancelToken();

  checkFileExist() async {
    var file = await getPathFile.getPath();
    filePath = '$file/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() => fileExist = fileExistCheck);
  }

  startDownload() async {
    cancelToken = CancelToken();
    var storPath = await getPathFile.getPath();
    filePath = '$storPath/$fileName';
    try {
      await Dio().download(widget.taskId['soal'], filePath,
          onReceiveProgress: (count, total) {
        setState(() => progress = (count / total));
      }, cancelToken: cancelToken);
      setState(() {
        downloading = false;
        fileExist = true;
      });
    } catch (e) {
      setState(() => downloading = false);
    }
  }

  cancelDownload() async {
    cancelToken.cancel();
    setState(() => downloading = false);
  }

  openFile() {
    OpenFile.open(filePath);
  }

  @override
  void initState() {
    super.initState();
    checkPermission();
    setState(() {
      fileName = path.basename(widget.taskId['soal']);
    });
    checkFileExist();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<TaskBloc>().add(LoadQuestionsEvent(weekId: taskId));
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        state.isAlert.isNotEmpty
            ? AppSnackbar.show(context, message: state.isAlert)
            : null;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Tugas Minggu ${widget.taskId['week']}")),
        body: isPermission
            ? ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  Text(
                    'Silahkan di unduh soal dibawah ini !',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: const Color(0xFF64558E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (widget.taskId['soal'].isEmpty ||
                          widget.taskId['soal'] == null) {
                        return AppSnackbar.show(context,
                            message: 'Belum ada soal yang diunggah');
                      } else {
                        fileExist && downloading == false
                            ? openFile()
                            : startDownload();
                        // context.read<TaskBloc>().add(DownloadSoalEvent(
                        //     url: widget.taskId['soal'],
                        //     week: widget.taskId['week'].toString()));
                      }
                    },
                    child: Text(
                      downloading
                          ? 'Mendownload ... ${progress.toStringAsFixed(2)}%'
                          : fileExist
                              ? 'Buka soal'
                              : 'Klik untuk unduh soal',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Upload jawaban',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            : TextButton(
                onPressed: () => checkPermission(),
                child: Text('Ijinkan akses penyimpanan')),
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
