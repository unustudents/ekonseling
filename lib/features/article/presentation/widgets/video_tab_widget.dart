import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/article_bloc.dart';

class VideoTabWidget extends StatelessWidget {
  const VideoTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state.videoIsLoading)
          return const Center(child: CircularProgressIndicator());
        if (state.videoData.isEmpty)
          return const Center(child: Text("Admin belum mengunggah video"));
        if (state.videoDataError.isNotEmpty)
          return Center(child: Text(state.videoDataError));
        if (state.videoDataKategori.isEmpty)
          return const Center(
              child: Text("Admin belum mengunggah video dalam kategori ini"));

        log('build Video Tab Widget', name: 'Artikel');

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            var data = state.videoDataKategori[index];

            return GestureDetector(
              onTap: () async {
                // Fungsi untuk meluncurkan URL di aplikasi YouTube
                Uri uri = Uri.parse(data['url_video'].toString());
                if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
                  throw 'Tidak dapat membuka URL';
                }
              },
              child: Padding(
                // height: 350 * 9 / 16
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          data['thumbnail'].toString(),
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        // height: 52,
                        decoration: const BoxDecoration(color: Colors.white70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'].toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data['subtitle'].toString(),
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox.shrink(),
          itemCount: state.videoDataKategori.length,
        );
      },
    );
  }
}
