import 'dart:async';
import 'package:blog_app/utils/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('object');
    Timer(Duration(seconds: 3), () {
      context.goNamed('/login');
    });

    // BlocListener<AppUserCubit, AppUserState>(
    //   listener: (context, state) {
    //     if (state is AppUserLoggedInState) {
    //       context.goNamed('/blog-page');
    //     } else {
    //       context.goNamed('/login');
    //     }
    //   },
    //   // child: Container(),
    // );
    // // BlocSelector<AppUserCubit, AppUserState, bool>(
    //   selector: (state) {
    //     return state is AppUserLoggedInState;
    //   },
    //   builder: (context, isLoggedIn) {
    //     print(isLoggedIn);
    //     Timer(const Duration(seconds: 3), () {
    //       print(isLoggedIn);

    //       if (isLoggedIn) {
    //         // context.goNamed("/blog-page");
    //         return context.goNamed("/blog-page");
    //       }
    //       return context.goNamed("/login");
    //     });
    //     return LoginScreen();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Image.asset('asset/feather-pen.png', height: 140, width: 140),

                Text(
                  "BlogSphere",
                  style: GoogleFonts.aboreto(
                    textStyle: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gradiant1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
