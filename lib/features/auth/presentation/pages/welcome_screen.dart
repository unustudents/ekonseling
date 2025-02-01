import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../routes/app_pages.dart';
import '../cubit/auth_cubit.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Variabel untuk mendapatkan ukuran layar
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Jika sedang loading, maka akan menampilkan indicator loading
        // if (state.isLoading) return;
        if (state.status == AuthStatus.loading) return;
        // Jika user belum login, maka akan diarahkan ke halaman login
        // if (!state.isAuthenticated) {
        if (state.status == AuthStatus.failure) {
          context.goNamed(Routes.login);
        }
        if (state.status == AuthStatus.authenticated) {
          // Jika user sudah login, maka akan diarahkan ke halaman home
          context.goNamed(Routes.home);
        }
      },
      child: Material(
        color: Colors.white,
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
                text: 'Academic - ',
                style: TextStyle(
                  fontSize: size.width * 0.06, // Responsif berdasarkan lebar layar
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

            // INDICATOR LOADING
            LoadingAnimationWidget.progressiveDots(color: Colors.grey, size: 30),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
