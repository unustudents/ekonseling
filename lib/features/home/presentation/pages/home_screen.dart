import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Column(
                        children: [
                          IconButton(onPressed: () {}, icon: const Icon(Icons.smart_button)),
                          const Text("Marah"),
                        ],
                      )
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),

            // KONSELOR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Konselor",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(onTap: () {}, child: const Text("Lihat semua")),
                ],
              ),
            ),
            const Gap(20),
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
                height: 115,
                viewportFraction: 0.32,
                padEnds: false,
                enableInfiniteScroll: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
