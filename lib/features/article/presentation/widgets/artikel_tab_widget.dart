import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../routes/app_pages.dart';
import '../cubit/article_cubit.dart';

class ArtikelTabWidget extends StatelessWidget {
  const ArtikelTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, state) {
        if (state.artikelIsLoading) return Center(child: LoadingAnimationWidget.progressiveDots(color: Colors.white, size: 60));
        if (state.artikelData.isEmpty) return Center(child: Text("Admin belum mengunggah artikel"));
        if (state.artikelDataError.isNotEmpty) return Center(child: Text(state.artikelDataError));
        if (state.artikelDataKategori.isEmpty) return Center(child: Text("Admin belum mengunggah artikel dalam kategori ini"));

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
      },
    );
  }
}
