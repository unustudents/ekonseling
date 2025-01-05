import 'package:flutter/material.dart';

import '../bloc/article_bloc.dart';

class VideoTabWidget extends StatelessWidget {
  const VideoTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ArticleBloc, ArticleState, List<Map<String, dynamic>>>(
      selector: (state) => state.videoData,
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (state.isEmpty) return const Center(child: Text("Admin belum mengunggah video"));
            return Container(
              // height: 350 * 9 / 16,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        state[index]['url_video'].toString(),
                        width: 1000,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      // height: 52,
                      decoration: const BoxDecoration(color: Colors.white70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state[index]['title'].toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            state[index]['subtitle'].toString(),
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox.shrink(),
          itemCount: state.length,
        );
      },
    );
  }
}
