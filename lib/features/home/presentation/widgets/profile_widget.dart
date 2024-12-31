import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(FetchDataEvent());
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
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) => current is HomeLoaded,
                    builder: (context, state) {
                      if (state is HomeLoading) return Text('....');

                      if (state is HomeError) print('Error = ${state.message}');

                      if (state is HomeLoaded) {
                        return Text(state.userName.toUpperCase().toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
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
