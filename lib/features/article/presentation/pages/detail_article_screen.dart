import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailArticleScreen extends StatelessWidget {
  final Map<String, dynamic> articleMap;
  const DetailArticleScreen({super.key, required this.articleMap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(articleMap['profile_url'].toString()),
                  onBackgroundImageError: (exception, stackTrace) => const Icon(Icons.person),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articleMap['author'].toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Konselor',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                articleMap['image_url'].toString(),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              articleMap['title'].toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            Text(
              "${articleMap['created_at']} - ${articleMap['read_time_minutes']} menit",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),
            Text(
              articleMap['content'].toString(),
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
