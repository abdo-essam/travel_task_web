import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'dart:async';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, AppRoutes.tripsScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgLogoipsum3321,
              height: 80.h,
              width: 164.h,
            ),
            SizedBox(height: 24.h),
            CircularProgressIndicator(
              color: appTheme.orange200,
            ),
          ],
        ),
      ),
    );
  }
}