import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';
import '../widgets/artikel_widget.dart';
import '../widgets/konselor_widget.dart';
import '../widgets/profile_widget.dart';
import '../widgets/suasanahati_widget.dart';
import '../widgets/video_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: ListView(padding: EdgeInsets.symmetric(vertical: 22), children: [
        // PROFILE
        ProfileWidget(),
        SizedBox(height: 22),
        // COROUSEL SLIDER
        VideoWidget(),
        SizedBox(height: 22),
        // SUASANA HATI
        SuasanaHatiWidget(),
        // KONSELOR -- PROFILE
        KonselorWidget(),
        // ARTIKEL -- KONTEN
        ArtikelWidget(),
      ]),
    );
  }
}
