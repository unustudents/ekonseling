import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/snackbar.dart';
import '../cubit/detail_task_cubit.dart';

class DetailTaskScreen extends StatelessWidget {
  final Map<String, dynamic> taskId;

  const DetailTaskScreen({super.key, required this.taskId});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailTaskCubit, DetailTaskState>(
      listener: (context, state) {
        // state.isAlert.isNotEmpty ? AppSnackbar.show(context, message: state.isAlert) : null;
        // Ketika status downloading maka tampilkan loading
        if (state.status == DetailTaskStatus.loading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(child: LoadingAnimationWidget.progressiveDots(color: Colors.white, size: 60)),
          );
          // } else if (state.status != DetailTaskStatus.initial) {
          //   if (Navigator.canPop(context)) Navigator.pop(context);
          //   // if (state.status != DetailTaskStatus.loading) Navigator.pop(context);
        }
        // Ketika error
        if (state.status == DetailTaskStatus.error) {
          AppSnackbar.show(context, msg: state.msg, status: Status.error);
        }
        // Ketika sukses
        if (state.status == DetailTaskStatus.success) {
          AppSnackbar.show(context, msg: state.msg, status: Status.success);
        }
        // Ketika file berhasil di download
        if (state.success.isNotEmpty) {
          AppSnackbar.show(context, msg: state.success, status: Status.success);
          Navigator.pop(context);
        }
      },
      builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text("Tugas Minggu ${taskId['week']}")),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              if (state.isPermission && taskId["soal"] != null || taskId["soal"].isNotEmpty) ...[
                Text(
                  'Silahkan di unduh soal dibawah ini !',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Material(
                  shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  color: const Color(0xFF64558E),
                  type: MaterialType.button,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // state.isFileExist && state.isDownloading == false
                              state.isFileExist //? print(state.isFileExist) : print('unduh ${state.isFileExist} ${state.status}');
                                  ? context.read<DetailTaskCubit>().onOpenFile()
                                  : context.read<DetailTaskCubit>().onDownloadQuestion(url: '${taskId['soal']}');
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                // state.isDownloading
                                state.status == DetailTaskStatus.downloading
                                    ? 'Mendownload ... ${state.progress.toStringAsFixed(2)}%'
                                    : state.isFileExist
                                        ? 'Buka file soal'
                                        : 'Klik untuk unduh soal',
                                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        if (state.isFileExist) ...[
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                            indent: 5,
                            endIndent: 5,
                            width: 1,
                          ),
                          IconButton(
                            alignment: Alignment.center,
                            onPressed: () => context.read<DetailTaskCubit>().onDeleteFileSoal(),
                            icon: Icon(Icons.delete, color: Colors.white),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(vertical: 15),
                //     backgroundColor: const Color(0xFF64558E),
                //     foregroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                //   ),
                //   onPressed: () {
                //     if (taskId['soal'].isEmpty || taskId['soal'] == null) {
                //       return AppSnackbar.show(context, message: 'Belum ada soal yang diunggah');
                //     } else {
                //       state.isFileExist && state.isDownloading == false ? context.read<DetailTaskCubit>().onOpenFile() : context.read<DetailTaskCubit>().onDownloadQuestion(url: '${taskId['soal']}');
                //     }
                //   },
                //   child: Text(
                //     state.isDownloading
                //         ? 'Mendownload ... ${state.progress.toStringAsFixed(2)}%'
                //         : state.isFileExist
                //             ? 'Buka soal'
                //             : 'Klik untuk unduh soal',
                //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                //   ),
                // ),
                const SizedBox(height: 10),
                Text(
                  'Kerjakan soal yang anda unduh sesuai intruksi yang tertera pada soal tersebut !',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
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
                              context.read<DetailTaskCubit>().onRemoveFile(file);
                            },
                          ),
                        ),
                      ),
                      // for (var file in state.fileSelected)
                      TextButton.icon(
                          onPressed: () {
                            context.read<DetailTaskCubit>().onSelectFile();
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
                      context.read<DetailTaskCubit>().onSelectFile();
                    } else {
                      context.read<DetailTaskCubit>().onUploadTask(state.fileSelected);
                      // AppSnackbar.show(context, message: 'Kirim');
                    }
                  },
                  child: Text(
                    state.fileSelected.isEmpty ? 'Upload jawaban' : 'Kirim jawaban',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                // SizedBox(height: 20),
              ] else if (taskId['soal'].isEmpty || taskId['soal'] == null) ...[
                Text('Belum ada soal yang diunggah', style: const TextStyle(fontSize: 18)),
              ] else ...[
                GestureDetector(onTap: () => context.read<DetailTaskCubit>().onCheckPermission(), child: Center(child: Text('Ijinkan akses penyimpanan'))),
              ]
            ],
          )),
    );
  }
}
