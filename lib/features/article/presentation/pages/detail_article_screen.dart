import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailArticleScreen extends StatelessWidget {
  final String articleId;
  const DetailArticleScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    print(articleId);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/250?image=1'), // Replace with your image asset
                  radius: 20,
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Susilowati',
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
                'https://picsum.photos/800/450',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Berlatih bersikap percaya diri',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '12 Maret 2024 - 5 menit',
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
            const Text(
              'Percaya diri adalah kunci untuk mencapai banyak hal dalam hidup. '
              'Namun, tidak semua orang dilahirkan dengan rasa percaya diri yang tinggi. '
              'Berlatih untuk menjadi lebih percaya diri adalah proses yang membutuhkan waktu dan usaha. '
              'Berikut adalah beberapa tips yang dapat membantu Anda meningkatkan rasa percaya diri Anda:\n\n'
              '1. Kenali diri Anda: Mengetahui kekuatan dan kelemahan Anda adalah langkah pertama untuk membangun rasa percaya diri. '
              'Dengan memahami diri sendiri, Anda dapat fokus pada hal-hal yang dapat Anda tingkatkan dan merayakan pencapaian Anda.\n\n'
              '2. Tetapkan tujuan kecil: Mulailah dengan menetapkan tujuan kecil yang dapat dicapai. '
              'Setiap kali Anda mencapai tujuan tersebut, Anda akan merasa lebih percaya diri untuk menghadapi tantangan yang lebih besar.\n\n'
              '3. Berpikir positif: Pikiran negatif dapat merusak rasa percaya diri Anda. '
              'Cobalah untuk menggantikan pikiran negatif dengan pikiran positif. '
              'Ingatkan diri Anda tentang hal-hal baik yang telah Anda capai dan fokus pada potensi Anda.\n\n'
              '4. Jaga penampilan: Penampilan yang rapi dan bersih dapat meningkatkan rasa percaya diri Anda. '
              'Ketika Anda merasa baik tentang penampilan Anda, Anda akan merasa lebih percaya diri dalam berinteraksi dengan orang lain.\n\n'
              '5. Latihan berbicara di depan umum: Berbicara di depan umum adalah salah satu cara terbaik untuk meningkatkan rasa percaya diri. '
              'Mulailah dengan berbicara di depan teman atau keluarga, kemudian tingkatkan ke audiens yang lebih besar.\n\n'
              '6. Kelilingi diri Anda dengan orang-orang positif: Lingkungan yang positif dapat membantu Anda merasa lebih percaya diri. '
              'Cari teman-teman yang mendukung dan menginspirasi Anda untuk menjadi versi terbaik dari diri Anda.\n\n'
              '7. Jangan takut gagal: Kegagalan adalah bagian dari proses belajar. '
              'Jangan biarkan kegagalan menghancurkan rasa percaya diri Anda. '
              'Sebaliknya, gunakan kegagalan sebagai kesempatan untuk belajar dan tumbuh.\n\n'
              'Dengan mengikuti tips-tips di atas, Anda dapat mulai membangun rasa percaya diri yang lebih kuat. '
              'Ingatlah bahwa proses ini membutuhkan waktu dan kesabaran. '
              'Tetaplah konsisten dan jangan menyerah, karena rasa percaya diri yang tinggi akan membuka banyak pintu kesempatan dalam hidup Anda.',
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
