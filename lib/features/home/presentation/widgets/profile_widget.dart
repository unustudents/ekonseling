// // import 'dart:developer';

// import 'package:flutter/material.dart';

// import '../cubit/home_cubit.dart';

// class ProfileWidget extends StatelessWidget {
//   const ProfileWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // log(name: 'Home_Screen', 'Building Profile_Widget');
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text('Halo! ',
//                       style:
//                           TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
//                   BlocSelector<HomeCubit, HomeState, String>(
//                     selector: (state) => state.userName,
//                     builder: (context, state) {
//                       // log(
//                       //     name: 'Home_Screen',
//                       //     'Building Profile_Widget - BlocSelector');
//                       if (state.isNotEmpty) {
//                         return Text('${state.toUpperCase()} 👋',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16));
//                       }
//                       return Text('....');
//                     },
//                   ),
//                 ],
//               ),
//               Text(
//                 'Ayo mulai konseling!',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600, height: 2, fontSize: 14),
//               )
//             ],
//           ),
//           // GestureDetector(
//           //   onTap: () =>
//           //       AppSnackbar.show(context, msg: 'Sedang dalam pengembangan ...'),
//           //   child: const Icon(Icons.notifications_none_outlined),
//           // ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../cubit/home_cubit.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileText(textTheme: textTheme),
        ],
      ),
    );
  }
}

class _ProfileText extends StatelessWidget {
  final TextTheme textTheme;

  const _ProfileText({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocSelector<HomeCubit, HomeState, String>(
          selector: (state) => state.userName,
          builder: (context, userName) {
            return RichText(
              text: TextSpan(
                text: 'Halo! ',
                style:
                    textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                    text: userName.isNotEmpty
                        ? '${userName.toUpperCase()} 👋'
                        : '....',
                    style: textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
        Text(
          'Ayo mulai konseling!',
          style: textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600, height: 2),
        ),
      ],
    );
  }
}
