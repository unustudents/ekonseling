// Import necessary packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../cubit/home_cubit.dart'; // Import HomeCubit and HomeState

// Define a stateless widget for KonselorWidget
class KonselorWidget extends StatelessWidget {
  const KonselorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding for the header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Header text
              const Text(
                "Konselor",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF64558E),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // BlocSelector to get konselorProfiles from HomeCubit
        BlocSelector<HomeCubit, HomeState, List<Map<String, dynamic>>>(
          selector: (state) => state.konselorProfiles,
          builder: (context, state) {
            return CarouselSlider.builder(
              itemCount: state.length,
              itemBuilder: (context, index, realIndex) {
                // If no konselor profiles are available
                if (state.isEmpty) {
                  return Center(child: const Text('Belum ada konselor ...'));
                }

                // Display konselor profile
                return SizedBox.square(
                  dimension: 120,
                  child: GestureDetector(
                    onTap: () => showModelBottom(
                        context: context,
                        name: state[index]['name'].toString(),
                        uriProfile: state[index]['url_profil'].toString()),
                    child: Column(
                      children: [
                        // Profile image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            state[index]['url_profil'].toString(),
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/user.png',
                                    width: 90, fit: BoxFit.scaleDown),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Konselor name
                        Text(
                          state[index]['name'].toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
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

  // Function to show modal bottom sheet with konselor details
  void showModelBottom(
      {required BuildContext context,
      required String name,
      required String uriProfile}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag indicator
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: MediaQuery.of(context).size.width / 4,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Konselor details card
            Card(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    // Konselor profile image
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(uriProfile),
                    ),
                    SizedBox(width: 12),
                    // Konselor name and contact button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text("email", style: TextStyle(fontSize: 14)),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(Icons.mail, color: Colors.white),
                          label: Text("Hubungi Konselor",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
