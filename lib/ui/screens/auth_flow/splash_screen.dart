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
      context,
      LoginScreen.name,
    );
  }

  @override
  Widget build(BuildContext context) { // in that time build will render
    return Scaffold(
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
