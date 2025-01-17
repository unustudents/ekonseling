import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../core/snackbar.dart';
import '../bloc/home_bloc.dart';

class KonselorWidget extends StatelessWidget {
  const KonselorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    log(name: 'Home_Screen', 'Building Konselor_Widget');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Konselor",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF64558E)),
              ),
              GestureDetector(
                onTap: () => AppSnackbar.show(context,
                    message: 'Sedang dalam pengembangan ...'),
                child: const Text(
                  "Lihat semua",
                  style: TextStyle(color: Color(0xFF64558E), fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        BlocSelector<HomeBloc, HomeState, List<Map<String, dynamic>>>(
          selector: (state) => state.konselorProfiles,
          builder: (context, state) {
            return CarouselSlider.builder(
              itemCount: state.length,
              itemBuilder: (context, index, realIndex) {
                if (state.isEmpty)
                  return Center(child: const Text('Belum ada konselor ...'));

                return SizedBox.square(
                  dimension: 120,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          state[index]['url_profil'].toString(),
                          // 'assets/images/user.png',
                          width: 90,
                          height: 90,
                          // height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('assets/images/user.png',
                                  width: 90, fit: BoxFit.scaleDown),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state[index]['name'].toString(),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: 120,
                viewportFraction: 0.35,
                padEnds: false,
                enableInfiniteScroll: false,
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
