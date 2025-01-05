import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../routes/app_pages.dart';
import '../bloc/article_bloc.dart';

class ArtikelTabWidget extends StatelessWidget {
  const ArtikelTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state.artikelIsLoading) return const Center(child: CircularProgressIndicator());
        if (state.artikelData.isEmpty) return Center(child: Text("Admin belum mengunggah artikel"));
        if (state.artikelDataError.isNotEmpty) return Center(child: Text(state.artikelDataError));
        if (state.artikelDataKategori.isEmpty) return Center(child: Text("Admin belum mengunggah artikel dalam kategori ini"));

        log('build Artikel Tab Widget', name: 'Artikel');
        // return Text(state.artikelData.toString());
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (BuildContext context, int index) {
            var data = state.artikelDataKategori[index];
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(data['profile_url'].toString()),
                      onBackgroundImageError: (exception, stackTrace) => AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      data['author'].toString(),
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => context.pushNamed(Routes.detailArticle, extra: data),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'].toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text(
                              data['content'].toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: true,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${data['created_at']} - ${data['read_time_minutes']} min read",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Image.network(
                        data['image_url'].toString(),
                        height: 120,
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Text(
                          "Tidak dapat memuat gambar",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 50, thickness: 0.1, color: Colors.black),
          itemCount: state.artikelDataKategori.length,
        );
        // return BlocSelector<ArticleBloc, ArticleState, List<Map<String, dynamic>>>(
        //   selector: (state) => state.artikelData,
        //   builder: (context, state) {
        //     if (state.isEmpty) return Center(child: Text("Admin belum mengunggah artikel"));

        //     return ListView.separated(
        //       padding: const EdgeInsets.all(20),
        //       itemBuilder: (BuildContext context, int index) {
        //         return Column(
        //           children: [
        //             Row(
        //               children: [
        //                 CircleAvatar(
        //                   radius: 15,
        //                   backgroundColor: Colors.grey,
        //                   backgroundImage: NetworkImage(state[index]['profile_url'].toString()),
        //                   onBackgroundImageError: (exception, stackTrace) => AssetImage('assets/images/user.png'),
        //                 ),
        //                 const SizedBox(width: 10),
        //                 Text(
        //                   state[index]['author'].toString(),
        //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        //                 ),
        //                 const Spacer(),
        //                 IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
        //               ],
        //             ),
        //             const SizedBox(height: 10),
        //             GestureDetector(
        //               onTap: () => context.pushNamed(Routes.detailArticle, extra: state[index]),
        //               child: Row(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Expanded(
        //                     child: Column(
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                           state[index]['title'].toString(),
        //                           style: TextStyle(fontWeight: FontWeight.w600),
        //                         ),
        //                         SizedBox(height: 10),
        //                         Text(
        //                           state[index]['content'].toString(),
        //                           overflow: TextOverflow.ellipsis,
        //                           maxLines: 3,
        //                           softWrap: true,
        //                           textAlign: TextAlign.justify,
        //                         ),
        //                         SizedBox(height: 10),
        //                         Text(
        //                           "${state[index]['created_at']} - ${state[index]['read_time_minutes']} min read",
        //                           style: TextStyle(color: Colors.black54),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   const SizedBox(width: 20),
        //                   Image.network(
        //                     state[index]['image_url'].toString(),
        //                     height: 120,
        //                     width: MediaQuery.of(context).size.width / 2 - 40,
        //                     fit: BoxFit.cover,
        //                     errorBuilder: (context, error, stackTrace) => Text(
        //                       "Tidak dapat memuat gambar",
        //                       overflow: TextOverflow.ellipsis,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         );
        //       },
        //       separatorBuilder: (BuildContext context, int index) => const Divider(height: 50, thickness: 0.1, color: Colors.black),
        //       itemCount: state.length,
        //     );
        //   },
        // );
      },
    );
  }
}
