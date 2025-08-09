// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphicCard extends StatefulWidget {
  final Widget child;
  const GlassmorphicCard({super.key, required this.child});

  @override
  State<GlassmorphicCard> createState() => _GlassmorphicCardState();
}

class _GlassmorphicCardState extends State<GlassmorphicCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dx = 0;
  double _dy = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      onHover: (event) {
        final containerSize = context.size;
        if (containerSize != null) {
          setState(() {
            _dx =
                (event.localPosition.dx - containerSize.width / 2) /
                (containerSize.width / 2);
            _dy =
                (event.localPosition.dy - containerSize.height / 2) /
                (containerSize.height / 2);
          });
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final rotationValue = _controller.value * 0.05;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_dx * rotationValue)
            ..rotateX(-_dy * rotationValue);
          return Transform(
            transform: transform,
            alignment: FractionalOffset.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          _controller.value * 0.1,
                        ),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
