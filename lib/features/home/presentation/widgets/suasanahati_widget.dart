import 'dart:developer';

import 'package:flutter/material.dart';

class SuasanaHatiWidget extends StatelessWidget {
  SuasanaHatiWidget({super.key});

  final List<Map<String, dynamic>> suasana = [
    {"icon": Icons.sentiment_dissatisfied_outlined, "teks": "Sedih"},
    {"icon": Icons.sentiment_neutral_outlined, "teks": "Netral"},
    {"icon": Icons.sentiment_very_satisfied_outlined, "teks": "Bahagia"},
  ];

  @override
  Widget build(BuildContext context) {
    log(name: 'Home_Screen', 'Building SuasanaHati_Widget');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bagaimana suasana hatimu hari ini ?",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: suasana.map((e) {
                return Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(e["icon"], size: 50),
                      color: const Color(0xFF64558E),
                    ),
                    Text(
                      e["teks"],
                      style: const TextStyle(color: Color(0xFF64558E)),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
