import 'package:flutter/material.dart';

import '../../../../routes/app_pages.dart';
import '../bloc/task_bloc.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tugas")),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: Text('Memuat data ...'));
          }
          print('object');
          if (state is TaskError) return Center(child: Text(state.message));
          if (state is TaskEmpty) return Center(child: Text(state.message));
          if (state is TaskLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    context.pushNamed(Routes.detailTask,
                        extra: state.tasks[index]['week'].toString());
                  },
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey.shade300)),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF64558E),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    'Tugas Minggu ${state.tasks[index]['week']}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: const Text('Isi tugas anda dan akan kami review'),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
