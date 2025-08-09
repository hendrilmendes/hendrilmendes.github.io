// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Offset speed;
  Particle({required this.position, required this.speed});
}

class AnimatedParticleBackground extends StatefulWidget {
  const AnimatedParticleBackground({super.key});
  @override
  State<AnimatedParticleBackground> createState() =>
      _AnimatedParticleBackgroundState();
}

class _AnimatedParticleBackgroundState extends State<AnimatedParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..addListener(() {
            _updateParticles();
            if (mounted) {
              setState(() {});
            }
          })
          ..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeParticles());
  }

  void _initializeParticles() {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    const particleCount = 35;
    particles = List.generate(
      particleCount,
      (index) => Particle(
        position: Offset(
          _random.nextDouble() * size.width,
          _random.nextDouble() * size.height,
        ),
        speed: Offset(
          (_random.nextDouble() - 0.5) * 0.4,
          (_random.nextDouble() - 0.5) * 0.4,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateParticles() {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    for (var p in particles) {
      p.position += p.speed;
      if (p.position.dx < 0 || p.position.dx > size.width) {
        p.speed = Offset(-p.speed.dx, p.speed.dy);
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        p.speed = Offset(p.speed.dx, -p.speed.dy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ParticlePainter(particles: particles),
      child: Container(),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Paint _paint = Paint()..strokeWidth = 0.5;

  _ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    const connectionDistance = 100.0;
    for (var p in particles) {
      _paint.color = Colors.white.withOpacity(0.8);
      canvas.drawCircle(p.position, 1.5, _paint);
      for (var other in particles) {
        final distance = (p.position - other.position).distance;
        if (distance < connectionDistance) {
          _paint.color = Colors.white.withOpacity(
            1.0 - (distance / connectionDistance),
          );
          canvas.drawLine(p.position, other.position, _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
