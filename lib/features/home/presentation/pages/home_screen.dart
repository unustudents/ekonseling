import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekonseling/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> suasana = [
      // {"icon": Icons.sentiment_very_dissatisfied_outlined, "teks": "Marah"},
      {"icon": Icons.sentiment_dissatisfied_outlined, "teks": "Sedih"},
      {"icon": Icons.sentiment_neutral_outlined, "teks": "Netral"},
      // {"icon": Icons.sentiment_satisfied_outlined, "teks": "Senang"},
      {"icon": Icons.sentiment_very_satisfied_outlined, "teks": "Bahagia"},
    ];
    int currentIndex = 0;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 22),
          children: [
            // PROFILE
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'Halo! Xi La 👋\nAyo mulai konseling!',
                  //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  // ),
                  const Text.rich(
                    TextSpan(
                      text: 'Halo! ',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, height: 2),
                      children: [
                        TextSpan(
                          text: 'Xi La', // Bagian teks dinamis dari database
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' 👋\n'),
                        TextSpan(
                          text: 'Ayo mulai konseling!',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.notifications_none_outlined),
                  ),
                ],
              ),
            ),
            const Gap(22),

            // COROUSEL SLIDER
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 160,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
              ),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/250?image=$index',
                        width: 1000,
                        fit: BoxFit.cover,
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seputar konseling',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Apa itu konseling ? pentingkah konseling ?',
                              style: TextStyle(fontSize: 12, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const Gap(22),

            // SUASANA HATI
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bagaimana suasana hatimu hari ini ?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const Gap(20),
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: suasana.map((e) {
                        return Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(e["icon"], size: 50),
                              color: const Color(0xFF64558E),
                            ),
                            Text(
                              e["teks"],
                              style: const TextStyle(color: Color(0xFF64558E)),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  // CarouselSlider.builder(
                  //   itemCount: _suasana.length,
                  //   itemBuilder: (context, index, realIndex) {
                  //     final e = _suasana[index];
                  //     return Column(
                  //       children: [
                  //         IconButton(
                  //           onPressed: () {},
                  //           icon: Icon(e["icon"], size: 50),
                  //           color: const Color(0xFF64558E),
                  //         ),
                  //         Text(e["teks"], style: const TextStyle(color: Color(0xFF64558E))),
                  //       ],
                  //     );
                  //   },
                  //   options: CarouselOptions(
                  //     height: 100,
                  //     viewportFraction: 0.2,
                  //     padEnds: false,
                  //     enableInfiniteScroll: false,
                  //   ),
                  // ),
                  const Gap(20),
                ],
              ),
            ),

            // KONSELOR -- JUDUL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Konselor",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF64558E)),
                  ),
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lihat semua"))),
                    child: const Text(
                      "Lihat semua",
                      style: TextStyle(color: Color(0xFF64558E), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),

            // KONSELOR -- PROFILE
            CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndex) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://picsum.photos/250?image=$index',
                        width: 90,
                        // height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(5),
                    Text("Konselor $index"),
                  ],
                );
              },
              options: CarouselOptions(
                height: 120,
                viewportFraction: 0.3,
                padEnds: false,
                enableInfiniteScroll: false,
              ),
            ),
            const Gap(20),

            // ARTIKEL -- JUDUL
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Artikel Populer",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF64558E)),
              ),
            ),

            // ARTIKEL -- KONTEN
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage('https://picsum.photos/250?image=1'),
                      ),
                      const Gap(10),
                      const Text(
                        "Susilawati",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      const Spacer(),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
                    ],
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Berlatih bersikap percaya diri",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Gap(10),
                            Text(
                              "Percaya diri adalah salah satu sikap penting yang membantu seseorang meraih kesuksesan dalam berbagai aspek kehidupan. Memiliki rasa perca...",
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              textAlign: TextAlign.justify,
                            ),
                            Gap(10),
                            Text("12 Mar - 5 min read", style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Image.network('https://picsum.photos/250?image=1', width: MediaQuery.of(context).size.width / 2 - 40, fit: BoxFit.cover),
                    ],
                  ),
                ],
              ),
              // children: List.generate(
              //   5,
              //   (index) => Column(
              //     children: [
              //       const Gap(10),
              //       Row(
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(8),
              //             child: Image.network(
              //               'https://picsum.photos/250?image=$index',
              //               width: 100,
              //               height: 100,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //           const Gap(10),
              //           Expanded(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   "Judul Artikel $index",
              //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //                 ),
              //                 const Gap(5),
              //                 Text(
              //                   "Deskripsi artikel $index",
              //                   style: const TextStyle(color: Colors.black54),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) => currentIndex = index,
        items: [
          SalomonBottomBarItem(icon: const Icon(Icons.home_outlined), title: const Text("Home")),
          SalomonBottomBarItem(icon: const Icon(Icons.article), title: const Text("Artikel")),
          SalomonBottomBarItem(icon: const Icon(Icons.task), title: const Text("Tugas")),
          SalomonBottomBarItem(icon: const Icon(Icons.person_outline), title: const Text("Profil")),
        ],
      ),
    );
  }
}
