import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../routes/app_pages.dart';
import '../bloc/auth_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          print('AuthUnauthenticated');
          context.goNamed(Routes.login);
        }
        if (state is AuthAuthenticated) {
          print('AuthAuthenticated');
          context.goNamed(Routes.home);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // GAMBAR WELLCOMING
              Spacer(flex: 2),
              SvgPicture.asset(
                'assets/images/undraw_welcoming.svg',
                fit: BoxFit.contain,
                height: size.height * 0.3,
              ),
              Spacer(flex: 1),

              // TEKS EKONSELING
              Text.rich(
                TextSpan(
                  text: 'Academy - ',
                  style: TextStyle(
                    fontSize:
                        size.width * 0.06, // Responsif berdasarkan lebar layar
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: 'Fun',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),

              // crete progress indicator here
              CircularProgressIndicator(),

              // TOMBOl MASUK
              // WelcomeButton(
              //   text: 'Masuk',
              //   backgroundColor: const Color(0xFF724778),
              //   textColor: Colors.white,
              //   onPressed: () {
              //     print(SupabaseConfig.client.auth.currentUser);
              //     context.goNamed(Routes.login);
              //   },
              // ),
              // SizedBox(height: size.height * 0.02),

              // TOMBOL DAFTAR
              // WelcomeButton(
              //   text: 'Daftar',
              //   backgroundColor: Colors.white,
              //   textColor: const Color(0xFF1E232C),
              //   borderColor: const Color(0xFF1E232C),
              //   onPressed: () => context.goNamed(Routes.register),
              // ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
