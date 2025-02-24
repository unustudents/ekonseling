// import 'package:flutter/material.dart';

// import '../../../../routes/app_pages.dart';
// import '../cubit/home_cubit.dart';

// class ArtikelWidget extends StatelessWidget {
//   const ArtikelWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: Text(
//             "Artikel Terbaru",
//             style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//                 color: Color(0xFF64558E)),
//           ),
//         ),
//         Container(
//           padding: const EdgeInsets.all(20),
//           child: BlocSelector<HomeCubit, HomeState, Map<String, dynamic>>(
//             selector: (state) => state.latestArticle,
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   // PROFILE AUTHOR
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 15,
//                         backgroundColor: Colors.grey,
//                         backgroundImage:
//                             NetworkImage(state['profile_url'].toString()),
//                         onBackgroundImageError: (exception, stackTrace) =>
//                             AssetImage('assets/images/user.png'),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         state['author'].toString(),
//                         style: TextStyle(
//                             fontWeight: FontWeight.w600, fontSize: 13),
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//                   const SizedBox(height: 10),

//                   // ARTICLE CONTENT
//                   GestureDetector(
//                     onTap: () =>
//                         context.pushNamed(Routes.detailArticle, extra: state),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 state['title'].toString(),
//                                 style: TextStyle(fontWeight: FontWeight.w600),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 state['content'].toString(),
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 3,
//                                 softWrap: true,
//                                 textAlign: TextAlign.justify,
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                   "${state['created_at']} - ${state['read_time_minutes']} min read",
//                                   style: TextStyle(color: Colors.black54)),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         Expanded(
//                           child: Image.network(
//                             state['image_url'].toString(),
//                             height: 120,
//                             width: MediaQuery.of(context).size.width / 2 - 40,
//                             fit: BoxFit.cover,
//                             // loadingBuilder: (context, child, loadingProgress) => Center(child: CircularProgressIndicator()),
//                             errorBuilder: (context, error, stackTrace) => Text(
//                               "Tidak dapat memuat gambar",
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../routes/app_pages.dart';
import '../cubit/home_cubit.dart';

class ArtikelWidget extends StatelessWidget {
  const ArtikelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Artikel Terbaru",
            style:
                textTheme.titleMedium?.copyWith(color: const Color(0xFF64558E)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: BlocSelector<HomeCubit, HomeState, Map<String, dynamic>>(
            selector: (state) => state.latestArticle,
            builder: (context, state) {
              if (state.isEmpty) {
                return const Center(child: Text("Belum ada artikel terbaru"));
              }

              return GestureDetector(
                onTap: () =>
                    context.pushNamed(Routes.detailArticle, extra: state),
                child: Column(
                  children: [
                    _AuthorProfile(
                      profileUrl: state['profile_url']?.toString(),
                      author: state['author']?.toString() ?? "Anonim",
                    ),
                    const SizedBox(height: 10),
                    _ArticleContent(state: state, textTheme: textTheme),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AuthorProfile extends StatelessWidget {
  final String? profileUrl;
  final String author;

  const _AuthorProfile({required this.profileUrl, required this.author});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.grey,
          backgroundImage:
              profileUrl != null ? NetworkImage(profileUrl!) : null,
          onBackgroundImageError: (_, __) =>
              const AssetImage('assets/images/user.png'),
        ),
        const SizedBox(width: 10),
        Text(author,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const Spacer(),
      ],
    );
  }
}

class _ArticleContent extends StatelessWidget {
  final Map<String, dynamic> state;
  final TextTheme textTheme;

  const _ArticleContent({required this.state, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state['title']?.toString() ?? "Judul tidak tersedia",
                style:
                    textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                state['content']?.toString() ?? "Konten tidak tersedia",
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              Text(
                "${state['created_at'] ?? 0} - ${state['read_time_minutes'] ?? 0} min read",
                style: textTheme.bodySmall?.copyWith(color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Image.network(
            state['image_url']?.toString() ?? "",
            height: 120,
            width: screenWidth / 2 - 40,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Text(
              "Tidak dapat memuat gambar",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
