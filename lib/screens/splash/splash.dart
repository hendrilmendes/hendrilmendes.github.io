import 'dart:async';
import 'package:flutter/material.dart';
import 'package:folio/utils/constants.dart';
import 'package:folio/utils/loader.dart';
import 'package:folio/widgets/bottom_navigation.dart';
import 'package:folio/widgets/desktop_navigation.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      bool isMobile = MediaQuery.of(context).size.width < 600;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isMobile
              ? const BottomNavigationContainer() // Para dispositivos móveis
              : const DesktopNavigationContainer(), // Para desktops
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF000515),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Carregando, aproveite e tome um café :)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            AnimatedLoadingText(),
          ],
        ),
      ),
    );
  }
}
