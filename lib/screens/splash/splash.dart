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

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        bool isMobile = MediaQuery.of(context).size.width < 600;
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder:
                (_, __, ___) =>
                    isMobile
                        ? const BottomNavigationContainer()
                        : const DesktopNavigationContainer(),
            transitionsBuilder: (_, anim, __, child) {
              return FadeTransition(opacity: anim, child: child);
            },
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Conteúdo principal com fade
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo animado
                  Icon(
                    Icons.coffee_rounded,
                    size: 72,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: defaultPadding * 2),

                  // Texto principal
                  Text(
                    'Carregando, aproveite e tome um café :)',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: defaultPadding * 2),

                  // Loader personalizado
                  const AnimatedLoadingText(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
