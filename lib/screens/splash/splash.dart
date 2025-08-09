// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:folio/configs/app_theme.dart';
import 'package:folio/widgets/bottom_navigation.dart';
import 'package:folio/widgets/desktop_navigation.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void _navigateToHome() {
    if (!mounted) return;

    bool isMobile = MediaQuery.of(context).size.width < 600;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => isMobile
            ? const BottomNavigationContainer()
            : const DesktopNavigationContainer(),
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cBackground,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _TerminalView(onComplete: _navigateToHome),
          ),
        ),
      ),
    );
  }
}

class _TerminalView extends StatelessWidget {
  final VoidCallback onComplete;
  const _TerminalView({required this.onComplete});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'RobotoMono',
      color: Colors.white,
      fontSize: 16,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('> ', style: textStyle),
            const _TypingText(text: 'iniciando main.dart'),
            const _BlinkingCursor(),
          ],
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LogLine(
              prefix: '[INFO] ',
              text: 'Inicializando motor Flutter...',
              accentColor: Colors.blue[300]!,
            ),
            _LogLine(
              prefix: '[INFO] ',
              text: 'Carregando assets e fontes...',
              accentColor: Colors.blue[300]!,
              delay: 1800.ms,
            ),
            _LogLine(
              prefix: '[INFO] ',
              text: 'Compilando componentes de UI...',
              accentColor: Colors.blue[300]!,
              delay: 2300.ms,
            ),
            _LogLine(
              prefix: '[OKAY] ',
              text: 'Design imersivo carregado.',
              accentColor: AppTheme.cPrimary,
              delay: 3000.ms,
            ),
            _LogLine(
              prefix: '[OKAY] ',
              text: 'Pronto para iniciar.',
              accentColor: AppTheme.cPrimary,
              delay: 3500.ms,
            ),

            _LogLine(
              prefix: '[SUCESS] ',
              text: 'Bem vindo',
              accentColor: Colors.greenAccent[400]!,
              delay: 4000.ms,
            ).animate().callback(
              duration: 4300.ms,
              callback: (_) => onComplete(),
            ),
          ],
        ),
      ],
    );
  }
}

class _LogLine extends StatelessWidget {
  final String prefix;
  final String text;
  final Color accentColor;
  final Duration delay;

  const _LogLine({
    required this.prefix,
    required this.text,
    required this.accentColor,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Text(
              prefix,
              style: TextStyle(
                fontFamily: 'RobotoMono',
                color: accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: 'RobotoMono',
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
        .animate(delay: delay)
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.5, curve: Curves.easeOut);
  }
}

class _TypingText extends StatefulWidget {
  final String text;
  const _TypingText({required this.text});

  @override
  State<_TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<_TypingText> {
  String _displayedText = '';
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_currentIndex < widget.text.length) {
        if (mounted) {
          setState(() {
            _displayedText += widget.text[_currentIndex];
            _currentIndex++;
          });
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: const TextStyle(
        fontFamily: 'RobotoMono',
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: const Text(
        '_',
        style: TextStyle(
          fontFamily: 'RobotoMono',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
