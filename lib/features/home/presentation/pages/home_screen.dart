import 'package:flutter/material.dart';

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
              padding: const EdgeInsets.only(left: 22, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SLIDER
            Container(),

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
                  Row(
                    children: [
                      Column(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.smart_button)),
                          Text("Marah"),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
