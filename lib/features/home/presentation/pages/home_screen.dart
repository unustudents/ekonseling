import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import '../widgets/profile_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> suasana = [
      {"icon": Icons.sentiment_dissatisfied_outlined, "teks": "Sedih"},
      {"icon": Icons.sentiment_neutral_outlined, "teks": "Netral"},
      {"icon": Icons.sentiment_very_satisfied_outlined, "teks": "Bahagia"},
    ];
    return BlocProvider(
        create: (context) => HomeBloc(),
        child: ListView(padding: EdgeInsets.symmetric(vertical: 22), children: [
          // PROFILE
          ProfileWidget(),
          SizedBox(height: 22),
          // COROUSEL SLIDER
          VideoWidget()
          // CarouselSlider.builder(
          //   options: CarouselOptions(
          //     height: 160,
          //     enlargeCenterPage: true,
          //     aspectRatio: 16 / 9,
          //     enableInfiniteScroll: true,
          //   ),
          //   itemCount: 1,
          //   itemBuilder: (BuildContext context, int index, int realIndex) {
          //     // if (state.dataVideo.isEmpty) {
          //     //   return const Center(child: Text('Admin belum mengunggah video'));
          //     // }
          //     return Stack(
          //       children: [
          //         ClipRRect(
          //           borderRadius: BorderRadius.circular(8),
          //           child: Image.network(
          //             "state.dataVideo[index]['url_video'].toString()",
          //             width: 1000,
          //             fit: BoxFit.cover,
          //             errorBuilder: (context, error, stackTrace) {
          //               return const Center(child: Text('Gagal memuat gambar'));
          //             },
          //           ),
          //         ),
          //         Positioned(
          //           bottom: 0,
          //           left: 0,
          //           right: 0,
          //           child: Container(
          //             padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //             height: 52,
          //             decoration: const BoxDecoration(color: Colors.white70),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   "state.dataVideo[index]['title'].toString()",
          //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //                 Text(
          //                   "state.dataVideo[index]['subtitle'].toString()",
          //                   style: TextStyle(fontSize: 12, color: Colors.black87),
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // )
        ]));

    // return BlocProvider(
    //   create: (BuildContext context) => HomeBloc(),
    //   child: BlocBuilder<HomeBloc, HomeState>(
    //     builder: (context, state) {
    //       if (state is HomeLoading) return const Center(child: CircularProgressIndicator());
    //       if (state is HomeError) return Center(child: Text('Error = ${state.message}'));
    //       if (state is HomeLoaded) {
    //         return ListView(
    //           padding: const EdgeInsets.symmetric(vertical: 22),
    //           children: [
    //

    //
    //             const Gap(22),

    //             // SUASANA HATI
    //             Container(
    //               padding: const EdgeInsets.symmetric(horizontal: 22),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const Text(
    //                     "Bagaimana suasana hatimu hari ini ?",
    //                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    //                   ),
    //                   const Gap(20),
    //                   Card(
    //                     color: Colors.white,
    //                     elevation: 5,
    //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       children: suasana.map((e) {
    //                         return Column(
    //                           children: [
    //                             IconButton(
    //                               onPressed: () {},
    //                               icon: Icon(e["icon"], size: 50),
    //                               color: const Color(0xFF64558E),
    //                             ),
    //                             Text(
    //                               e["teks"],
    //                               style: const TextStyle(color: Color(0xFF64558E)),
    //                             ),
    //                           ],
    //                         );
    //                       }).toList(),
    //                     ),
    //                   ),
    //                   const Gap(20),
    //                 ],
    //               ),
    //             ),

    //             // KONSELOR -- JUDUL
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 20),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   const Text(
    //                     "Konselor",
    //                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF64558E)),
    //                   ),
    //                   GestureDetector(
    //                     onTap: () async {
    //                       await SupabaseConfig.client.auth.signOut();
    //                       if (context.mounted) {
    //                         context.go(Routes.welcome);
    //                       }
    //                     },
    //                     child: const Text(
    //                       "Lihat semua",
    //                       style: TextStyle(color: Color(0xFF64558E), fontSize: 16),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const Gap(20),

    //             // KONSELOR -- PROFILE
    //             CarouselSlider.builder(
    //               itemCount: state.konselorProfiles.length,
    //               itemBuilder: (context, index, realIndex) {
    //                 return Column(
    //                   children: [
    //                     SizedBox.square(
    //                       dimension: 90,
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(50),
    //                         child: Image.network(
    //                           state.konselorProfiles[index]['url_profil'].toString(),
    //                           width: 90,
    //                           // height: 50,
    //                           fit: BoxFit.cover,
    //                           loadingBuilder: (context, child, loadingProgress) => CircularProgressIndicator(),
    //                           errorBuilder: (context, error, stackTrace) => Image.asset(
    //                             'assets/images/user.png',
    //                             width: 10,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     const Gap(5),
    //                     Text(state.konselorProfiles[index]['nama'].toString()),
    //                   ],
    //                 );
    //               },
    //               options: CarouselOptions(
    //                 height: 120,
    //                 viewportFraction: 0.3,
    //                 padEnds: false,
    //                 enableInfiniteScroll: false,
    //               ),
    //             ),
    //             const Gap(20),

    //             // ARTIKEL -- JUDUL
    //             const Padding(
    //               padding: EdgeInsets.symmetric(horizontal: 20),
    //               child: Text(
    //                 "Artikel Terbaru",
    //                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF64558E)),
    //               ),
    //             ),

    //             // ARTIKEL -- KONTEN
    //             Container(
    //               padding: const EdgeInsets.all(20),
    //               child: Column(
    //                 children: [
    //                   Row(
    //                     children: [
    //                       CircleAvatar(
    //                         radius: 15,
    //                         backgroundImage: NetworkImage(state.latestArticle['profile_url'].toString()),
    //                         onBackgroundImageError: (exception, stackTrace) => const Text('Gagal memuat gambar'),
    //                       ),
    //                       const Gap(10),
    //                       Text(
    //                         state.latestArticle['author'].toString(),
    //                         style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
    //                       ),
    //                       const Spacer(),
    //                       IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
    //                     ],
    //                   ),
    //                   const Gap(10),
    //                   Row(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Expanded(
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               state.latestArticle['title'].toString(),
    //                               style: TextStyle(fontWeight: FontWeight.w600),
    //                             ),
    //                             Gap(10),
    //                             Text(
    //                               state.latestArticle['content'].toString(),
    //                               overflow: TextOverflow.clip,
    //                               softWrap: true,
    //                               textAlign: TextAlign.justify,
    //                             ),
    //                             Gap(10),
    //                             Text("${state.latestArticle['created_at']} - ${state.latestArticle['read_time_minutes']} min read",
    //                                 style: TextStyle(color: Colors.black54)),
    //                           ],
    //                         ),
    //                       ),
    //                       const Gap(20),
    //                       Image.network(
    //                         state.latestArticle['image_url'],
    //                         width: MediaQuery.of(context).size.width / 2 - 40,
    //                         fit: BoxFit.cover,
    //                         errorBuilder: (context, error, stackTrace) => Text("Tidak dapat memuat gambar"),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         );
    //       }
    //       return const SizedBox.shrink();
    //     },
    //   ),
    // );
  }
}

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(StreamVideoDataEvent());
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomeVideoDataStream,
      builder: (context, state) {
        if (state is HomeLoading) return Text('Sedang memuat...');

        if (state is HomeError) print('Error = ${state.message}');

        if (state is HomeVideoDataStream) {
          print('Ada : ${state.dataVideo.length}');
          return CarouselSlider.builder(
            itemCount: state.dataVideo.length,
            itemBuilder: (context, index, realIndex) {
              if (state.dataVideo.isEmpty) {
                return const Center(child: Text('Admin belum mengunggah video'));
              }
              Map<String, dynamic> data = state.dataVideo[index];
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      data['url_video'].toString(),
                      width: 1000,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('Gagal memuat gambar'));
                      },
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['title'].toString(),
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            data['subtitle'].toString(),
                            style: TextStyle(fontSize: 12, color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              height: 160,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
            ),
          );
        }
        return Text(state.toString());
      },
    );
  }
}
