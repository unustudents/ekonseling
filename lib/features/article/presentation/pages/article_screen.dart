import 'package:flutter/material.dart';

import '../bloc/article_bloc.dart';
import '../widgets/artikel_tab_widget.dart';
import '../widgets/video_tab_widget.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<String> selectedChoice;

  @override
  void initState() {
    super.initState();
    selectedChoice = ValueNotifier<String>("Semua");

    // Inisialisasi TabController
    _tabController = TabController(length: 2, vsync: this);

    // Tambahkan listener untuk reset fillter ketika tab diubah
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        selectedChoice.value = "Semua";
        context
            .read<ArticleBloc>()
            .add(LoadKategoriDataArtikelEvent(kategori: selectedChoice.value));
        context
            .read<ArticleBloc>()
            .add(LoadKategoriDataVideoEvent(kategori: selectedChoice.value));
      } // Reset filter ke default
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    selectedChoice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final List<String> choices = ["Semua", "MI - ICBT", "Semangat", "Dedikasi", "Keterlibatan"];
    // var selectedChoice = ValueNotifier<String>(choices[0]);
    // var selectedChoice = ValueNotifier<String>("Semua");

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            controller: _tabController, // Hubungkan TabController
            tabs: const [
              Tab(text: "Artikel"),
              Tab(text: "Video"),
            ],
            padding: EdgeInsets.zero,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: BlocBuilder<ArticleBloc, ArticleState>(
              builder: (context, state) {
                if (state.kategoriIsLoading)
                  return Center(child: const CircularProgressIndicator());
                if (state.kategoriDataError.isNotEmpty)
                  return const Center(child: Text("Gagal memuat kategori"));
                return ValueListenableBuilder(
                  valueListenable: selectedChoice,
                  builder: (BuildContext context, String value, Widget? child) {
                    /* SIzeBox wajib digunakan untuk membungkus dan menentukan ketinggian ListView dengan scroll Horizontal */
                    return SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.kategoriData.length,
                        itemBuilder: (BuildContext context, int index) {
                          String kategori =
                              state.kategoriData[index]['name'].toString();
                          return ChoiceChip(
                            label: Text(
                              kategori.toString(),
                              style: TextStyle(
                                color: value == kategori
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            selected: value == kategori,
                            selectedColor: const Color(0xFF64558E),
                            onSelected: (selected) {
                              if (selected) {
                                /* selectedChoice.value harus di taruh di atas sebelum context.read (event) dipanggil. jika dibalik, mka error */
                                selectedChoice.value = kategori;
                                context.read<ArticleBloc>().add(
                                      _tabController.index == 0
                                          ? LoadKategoriDataArtikelEvent(
                                              kategori: kategori)
                                          : LoadKategoriDataVideoEvent(
                                              kategori: kategori),
                                    );
                              }
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(width: 8),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController, // Hubungkan TabController
            children: [
              // ARTIKEL -- KONTEN
              ArtikelTabWidget(),

              // VIDEO -- KONTEN
              VideoTabWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
