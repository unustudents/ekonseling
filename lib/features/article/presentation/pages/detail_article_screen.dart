import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../bloc/article_bloc.dart';

class DetailArticleScreen extends StatelessWidget {
  final String articleId;
  const DetailArticleScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        state.artikelDataById['profile_url'].toString(),
                      ), // Replace with your image asset
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.artikelDataById['author'].toString(),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Konselor',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.close),
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    state.artikelDataById['image_url'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  state.artikelDataById['title'].toString(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${state.artikelDataById['created_at']} - ${state.artikelDataById['read_time_minutes']} menit",
                      style: TextStyle(color: Colors.grey),
                    ),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {
                        // Add your save article logic here
                      },
                    ),
                    const Spacer(),
                  ],
                ),
                Text(
                  state.artikelDataById['content'].toString(),
                  textAlign: TextAlign.justify,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
