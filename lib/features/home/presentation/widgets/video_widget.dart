import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/home_cubit.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, List<Map<String, dynamic>>>(
      selector: (state) => state.dataVideo,
      builder: (context, state) {
        return CarouselSlider.builder(
          itemCount: state.length,
          itemBuilder: (context, index, realIndex) {
            if (state.isNotEmpty) {
              // return Text(state[index]['title'].toString());
              Map<String, dynamic> data = state[index];
              return GestureDetector(
                onTap: () async {
                  // Fungsi untuk meluncurkan URL di aplikasi YouTube
                  Uri uri = Uri.parse(data['url_video'].toString());
                  if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
                    throw 'Tidak dapat membuka URL';
                  }
                },
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        data['thumbnail'].toString(),
                        width: 1000,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text('Gagal memuat gambar'));
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        height: 52,
                        decoration: const BoxDecoration(color: Colors.white70),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              data['subtitle'].toString(),
                              style: TextStyle(fontSize: 12, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('Admin belum mengunggah video'));
          },
          options: CarouselOptions(
            height: 160,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true,
          ),
        );
      },
    );
  }
}
