import 'package:flutter/material.dart';

import '../../../../routes/app_pages.dart';
import '../cubit/task_cubit.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<TaskBloc>().add(LoadWeekEvent());
    return Scaffold(
      appBar: AppBar(title: const Text("Tugas")),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state.isLoading) return Center(child: Text('Memuat data ...'));
          // if (state.error.isNotEmpty) return Center(child: Text(state.error));
          if (state.week.isEmpty) return Center(child: Text('Admin belum mengunggah tugas'));

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: state.week.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  context.pushNamed(Routes.detailTask, extra: state.week[index]);
                },
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
                  'Tugas Minggu ${state.week[index]['week']}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('Isi tugas anda dan akan kami review'),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          );
        },
      ),
    );
  }
}
