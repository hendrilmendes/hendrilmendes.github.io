// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:folio/configs/app_theme.dart';
import 'package:folio/models/educacao.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key});
  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
    ]).animate(_controller);
    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
    ]).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [Color(0xFF0D47A1), Color(0xFF4A148C)],
            begin: _topAlignmentAnimation.value,
            end: _bottomAlignmentAnimation.value,
          ),
        ),
      ),
    );
  }
}

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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _updateParticles();
        return CustomPaint(
          painter: _ParticlePainter(particles: particles),
          child: Container(),
        );
      },
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
                  padding: const EdgeInsets.all(24),
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

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    educationData.sort((a, b) {
      final yearA = int.tryParse(a.year.split(' ').first) ?? 0;
      final yearB = int.tryParse(b.year.split(' ').first) ?? 0;
      return yearB.compareTo(yearA);
    });

    return Scaffold(
      backgroundColor: AppTheme.cBackground,
      body: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground()),
          const Positioned.fill(child: AnimatedParticleBackground()),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return _TimelineEntry(
                    education: educationData[index],
                    side: index.isEven ? TimelineSide.left : TimelineSide.right,
                  );
                }, childCount: educationData.length),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.of(context).padding.top + 80,
        24,
        40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppTheme.cPrimary, AppTheme.cSecondary],
                ).createShader(bounds),
                child: const Text(
                  'Jornada Acadêmica',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.5, curve: Curves.easeOutCubic),
          const SizedBox(height: 16),
          Text(
            'Cursos, certificações e formações que construíram a base do meu conhecimento.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
              height: 1.5,
            ),
          ).animate(delay: 200.ms).fadeIn(),
        ],
      ),
    );
  }
}

enum TimelineSide { left, right }

class _TimelineEntry extends StatelessWidget {
  final Education education;
  final TimelineSide side;

  const _TimelineEntry({required this.education, required this.side});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        final actualSide = isWide ? side : TimelineSide.right;

        Widget card = Expanded(
          flex: 5,
          child: EducationCard(education: education),
        );
        Widget node = _TimelineNode(year: education.year, type: education.type);
        Widget spacer = Expanded(flex: 5, child: Container());

        List<Widget> children = actualSide == TimelineSide.left
            ? [card, node, spacer]
            : [spacer, node, card];

        if (!isWide) {
          children = [node, const SizedBox(width: 20), card];
        }

        return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeOut)
            .slideX(
              begin: actualSide == TimelineSide.left ? -0.2 : 0.2,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}

class _TimelineNode extends StatelessWidget {
  final String year;
  final String type;
  const _TimelineNode({required this.year, required this.type});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(width: 2, color: Colors.white24),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: AppTheme.cBackground,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: AppTheme.cPrimary, width: 2),
            ),
          ),
          child: Icon(
            _getEducationIcon(type),
            color: AppTheme.cPrimary,
            size: 24,
          ),
        ).animate(onPlay: (c) => c.repeat(period: 1.seconds)),
      ],
    );
  }
}

class EducationCard extends StatelessWidget {
  final Education education;
  const EducationCard({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    final bool isClickable = education.certificateUrl != null;
    return InkWell(
      onTap: isClickable ? () => _launchURL(education.certificateUrl!) : null,
      borderRadius: BorderRadius.circular(16),
      hoverColor: Colors.transparent,
      child: GlassmorphicCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              education.year,
              style: const TextStyle(color: AppTheme.cSecondary, fontSize: 13),
            ),
            const SizedBox(height: 8),
            Text(
              education.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              education.institution,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 15,
              ),
            ),
            if (isClickable) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Ver Certificado',
                    style: TextStyle(
                      color: AppTheme.cPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.open_in_new_rounded,
                    color: AppTheme.cPrimary,
                    size: 16,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri)) throw 'Não foi possível abrir o link: $url';
}

IconData _getEducationIcon(String type) {
  switch (type.toLowerCase()) {
    case 'graduação':
      return Icons.school_rounded;
    case 'curso':
      return Icons.library_books_rounded;
    case 'certificação':
      return Icons.verified_rounded;
    case 'especialização':
      return Icons.workspace_premium_rounded;
    default:
      return Icons.book_rounded;
  }
}
