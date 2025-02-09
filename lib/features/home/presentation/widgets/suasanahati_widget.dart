import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class SuasanaHatiWidget extends StatefulWidget {
  const SuasanaHatiWidget({super.key});

  @override
  State<SuasanaHatiWidget> createState() => _SuasanaHatiWidgetState();
}

class _SuasanaHatiWidgetState extends State<SuasanaHatiWidget> {
  String? message;

  final List<Map<String, dynamic>> suasana = [
    {"icon": Icons.sentiment_dissatisfied_outlined, "teks": "Sedih", "msg": "Sepertinya kamu sedang tidak baik - baik saja, Yuk mulai bicara dengan konselor"},
    {"icon": Icons.sentiment_neutral_outlined, "teks": "Netral", "msg": "Terimakasih telah menjawab"},
    {"icon": Icons.sentiment_very_satisfied_outlined, "teks": "Bahagia", "msg": "Semoga harimu menyenangkan"},
  ];

  void _onIconPressed(int index) {
    setState(() {
      message = suasana[index]["msg"];
    });
    Timer(const Duration(seconds: 3), () {
      setState(() {
        message = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log(name: 'Home_Screen', 'Building SuasanaHati_Widget');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Bagaimana suasana hatimu hari ini ?",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 2.0, offset: Offset(0.8, 0.8)),
              ],
            ),
            constraints: const BoxConstraints(minHeight: 100),
            child: message == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: suasana.map((e) {
                      return Column(
                        children: [
                          IconButton(
                            onPressed: () => _onIconPressed(suasana.indexOf(e)),
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
                  )
                : Center(
                    child: Text(
                      message!,
                      style: const TextStyle(color: Color(0xFF64558E), fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
