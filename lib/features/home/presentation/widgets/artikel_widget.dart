import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';

class ArtikelWidget extends StatelessWidget {
  const ArtikelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Artikel Terbaru",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF64558E)),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: BlocSelector<HomeBloc, HomeState, Map<String, dynamic>>(
            selector: (state) => state.latestArticle,
            builder: (context, state) {
              return Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          state['profile_url'].toString(),
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) => CircularProgressIndicator(),
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset('assets/images/user.png', width: 30, height: 30, fit: BoxFit.scaleDown),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state['author'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      const Spacer(),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state['title'].toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 10),
                            Text(
                              state['content'].toString(),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 10),
                            Text("${state['created_at']} - ${state['read_time_minutes']} min read", style: TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.network(
                        state['image_url'].toString(),
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Text(
                          "Tidak dapat memuat gambar",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
