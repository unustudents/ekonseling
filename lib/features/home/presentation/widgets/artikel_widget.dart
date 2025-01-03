import 'package:ekonseling/routes/app_pages.dart';
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
                  // PROFILE AUTHOR
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(state['profile_url'].toString()),
                        onBackgroundImageError: (exception, stackTrace) => AssetImage('assets/images/user.png'),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        state['author'].toString(),
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                      const Spacer(),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ARTICLE CONTENT
                  GestureDetector(
                    onTap: () => context.pushNamed(Routes.detailArticle, extra: state),
                    child: Row(
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
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                softWrap: true,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 10),
                              Text("${state['created_at']} - ${state['read_time_minutes']} min read", style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Image.network(
                            state['image_url'].toString(),
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2 - 40,
                            fit: BoxFit.cover,
                            // loadingBuilder: (context, child, loadingProgress) => Center(child: CircularProgressIndicator()),
                            errorBuilder: (context, error, stackTrace) => Text(
                              "Tidak dapat memuat gambar",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
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
