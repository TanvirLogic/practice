import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/asset_paths.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen(); // This method will call first
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Delayed
    Navigator.pushReplacementNamed(
      // method -> pushReplacementNamed as we are using named navigation in routes
      // This thing is for mainly easy navigation process and less more code
      context,
      LoginScreen.name, // LoginScreen();
    );
  }

  @override
  Widget build(BuildContext context) {
    // in that time build will render
    return Scaffold(
      // Splash Screen UI , this will remain only 3 seconds
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetPaths.backgroundSvg,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Center(child: SvgPicture.asset(AssetPaths.logoSvg, height: 40)),
        ],
      ),
    );
  }
}
