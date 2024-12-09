import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'detail_article_screen.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> choices = ["Semua", "MI - ICBT", "Semangat", "Dedikasi", "Keterlibatan"];
    var selectedChoice = ValueNotifier<String>(choices[0]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: "Artikel"),
              Tab(text: "Video"),
            ],
            padding: EdgeInsets.zero,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: ValueListenableBuilder(
              valueListenable: selectedChoice,
              builder: (BuildContext context, String value, Widget? child) {
                return Wrap(
                  spacing: 8,
                  children: choices.map(
                    (choice) {
                      final isSelected = value == choice;
                      return ChoiceChip(
                        label: Text(
                          choice,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: const Color(0xFF64558E), // Warna chip saat dipilih
                        showCheckmark: false,
                        onSelected: (selected) => selectedChoice.value = selected ? choice : selectedChoice.value,

                        // if(selected)  selectedChoice.value = choice,
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              // ARTIKEL -- KONTEN
              Column(
                children: [
                  // ValueListenableBuilder(
                  //   valueListenable: selectedChoice,
                  //   builder: (BuildContext context, String value, Widget? child) {
                  //     return Wrap(
                  //       spacing: 8,
                  //       children: choices.map(
                  //         (choice) {
                  //           final isSelected = value == choice;
                  //           return ChoiceChip(
                  //             label: Text(
                  //               choice,
                  //               style: TextStyle(
                  //                 color: isSelected ? Colors.white : Colors.black,
                  //               ),
                  //             ),
                  //             selected: isSelected,
                  //             selectedColor: const Color(0xFF64558E), // Warna chip saat dipilih
                  //             showCheckmark: false,
                  //             onSelected: (selected) => selectedChoice.value = selected ? choice : selectedChoice.value,

                  //             // if(selected)  selectedChoice.value = choice,
                  //           );
                  //         },
                  //       ).toList(),
                  //     );
                  //   },
                  // ),

                  // ARTIKEL -- KONTEN
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.grey,
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailArticleScreen(),
                                  ),
                                );
                              },
                              child: Row(
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
                                  Image.network('https://picsum.photos/250?image=$index',
                                      width: MediaQuery.of(context).size.width / 2 - 40, fit: BoxFit.cover),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 50, thickness: 0.1, color: Colors.black),
                      itemCount: 2,
                    ),
                  ),
                ],
              ),

              // VIDEO -- KONTEN
              Column(
                children: [
                  Container(
                    // height: 350 * 9 / 16,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://picsum.photos/250?image=1',
                              width: 1000,
                              fit: BoxFit.cover,
                            ),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
