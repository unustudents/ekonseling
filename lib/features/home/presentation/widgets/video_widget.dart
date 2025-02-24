// import 'dart:math';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../cubit/home_cubit.dart';

// class VideoWidget extends StatelessWidget {
//   const VideoWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<HomeCubit, HomeState, List<Map<String, dynamic>>>(
//       selector: (state) => state.dataVideo,
//       builder: (context, state) {
//         if (state.isEmpty) {
//           return const Center(child: Text('Admin belum mengunggah video'));
//         }
//         return CarouselSlider.builder(
//           itemCount: min(state.length, 4),
//           itemBuilder: (context, index, realIndex) {
//             final data = state[index]; // Map<String, dynamic>
//             return GestureDetector(
//               onTap: () => _launchVideo(data['url_video'].toString()),
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.network(
//                       data['thumbnail']?.toString() ?? '',
//                       width: 1000,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return const Center(child: CircularProgressIndicator());
//                       },
//                       errorBuilder: (context, error, stackTrace) {
//                         return const Center(
//                             child: Icon(
//                           Icons.broken_image,
//                           size: 150,
//                           color: Colors.grey,
//                         ));
//                       },
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 5, horizontal: 10),
//                       height: 52,
//                       decoration: const BoxDecoration(color: Colors.white70),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             data['title'].toString(),
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             data['subtitle'].toString(),
//                             style:
//                                 TextStyle(fontSize: 12, color: Colors.black87),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//           options: CarouselOptions(
//             height: 160,
//             enlargeCenterPage: true,
//             aspectRatio: 16 / 9,
//             enableInfiniteScroll: true,
//           ),
//         );
//       },
//     );
//   }

//   // Fungsi untuk meluncurkan URL di aplikasi YouTube
//   Future<void> _launchVideo(String url) async {
//     final uri = Uri.parse(url);
//     if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
//       debugPrint('Tidak dapat membuka URL: $url');
//     }
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/home_cubit.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, List<Map<String, dynamic>>>(
      selector: (state) => state.dataVideo,
      builder: (context, state) {
        if (state.isEmpty) {
          return const Center(child: Text('Admin belum mengunggah video'));
        }

        return CarouselSlider.builder(
          itemCount: min(state.length, 4),
          itemBuilder: (context, index, realIndex) {
            return VideoCard(data: state[index]);
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

/// Widget terpisah untuk menampilkan satu video dalam carousel.
class VideoCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const VideoCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchVideo(data['url_video'].toString()),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7), // Efek gelap di bawah
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.darken,
              child: Image.network(
                data['thumbnail']?.toString() ?? '',
                width: 1000,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.broken_image, size: 50),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'].toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data['subtitle'].toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
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

  /// Fungsi helper untuk membuka video di YouTube
  Future<void> _launchVideo(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      debugPrint('Tidak dapat membuka URL: $url');
    }
  }
}

// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../cubit/home_cubit.dart';

// class VideoWidget extends StatelessWidget {
//   const VideoWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<HomeCubit, HomeState, List<Map<String, dynamic>>>(
//       selector: (state) => state.dataVideo,
//       builder: (context, state) {
//         if (state.isEmpty) {
//           return const Center(child: Text('Admin belum mengunggah video'));
//         }

//         return SizedBox(
//           height: 160,
//           child: PageView.builder(
//             itemCount: min(state.length, 4),
//             controller: PageController(viewportFraction: 0.9),
//             itemBuilder: (context, index) {
//               return VideoCard(data: state[index]);
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class VideoCard extends StatelessWidget {
//   final Map<String, dynamic> data;
//   const VideoCard({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _launchVideo(data['url_video'].toString()),
//       child: Stack(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: ShaderMask(
//               shaderCallback: (Rect bounds) {
//                 return LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     Colors.black87, // Efek gelap di bawah
//                   ],
//                 ).createShader(bounds);
//               },
//               blendMode: BlendMode.darken,
//               child: Image.network(
//                 data['thumbnail'].toString(),
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     data['title'].toString(),
//                     style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     data['subtitle'].toString(),
//                     style: const TextStyle(fontSize: 12, color: Colors.white70),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _launchVideo(String url) async {
//     Uri uri = Uri.parse(url);
//     if (Platform.isAndroid || Platform.isIOS) {
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       } else {
//         debugPrint('Gagal membuka URL: $url');
//       }
//     } else {
//       debugPrint('Fitur tidak didukung di platform ini');
//     }
//   }
// }
