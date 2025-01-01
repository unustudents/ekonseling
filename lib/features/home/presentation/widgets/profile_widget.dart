import 'dart:developer';

import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    log(name: 'Home_Screen', 'Building Profile_Widget');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Halo! ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  BlocSelector<HomeBloc, HomeState, String>(
                    selector: (state) => state.userName,
                    builder: (context, state) {
                      log(name: 'Home_Screen', 'Building Profile_Widget - BlocSelector');
                      if (state.isNotEmpty) {
                        return Text('${state.toUpperCase()} 👋', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
                      }
                      return Text('....');
                    },
                  ),
                ],
              ),
              Text(
                'Ayo mulai konseling!',
                style: TextStyle(fontWeight: FontWeight.w600, height: 2, fontSize: 14),
              )
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
    );
  }
}
