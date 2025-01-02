import 'package:flutter/material.dart';

import '../../../../routes/app_pages.dart';
import '../bloc/article_bloc.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> choices = ["Semua", "MI - ICBT", "Semangat", "Dedikasi", "Keterlibatan"];
    var selectedChoice = ValueNotifier<String>(choices[0]);
    return BlocProvider(
      create: (context) => ArticleBloc(),
      child: DefaultTabController(
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
                      child: BlocSelector<ArticleBloc, ArticleState, List<Map<String, dynamic>>>(
                        selector: (state) => state.artikelData,
                        builder: (context, state) {
                          return ListView.separated(
                            padding: const EdgeInsets.all(20),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(state[index]['profile_url'].toString()),
                                        onBackgroundImageError: (exception, stackTrace) => AssetImage('assets/images/user.png'),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        state[index]['author'].toString(),
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                      ),
                                      const Spacer(),
                                      IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () => context.pushNamed(Routes.detailArticle, pathParameters: {'id': '1'}),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state[index]['title'].toString(),
                                                style: TextStyle(fontWeight: FontWeight.w600),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                state[index]['content'].toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                softWrap: true,
                                                textAlign: TextAlign.justify,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "${state[index]['created_at']} - ${state[index]['read_time_minutes']} min read",
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Image.network(
                                          state[index]['image_url'].toString(),
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
                            itemCount: state.length,
                          );
                        },
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
      ),
    );
  }
}
