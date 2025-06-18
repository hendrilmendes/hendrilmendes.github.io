// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:folio/models/habilidades.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
            colors: const [Color(0xFF1A237E), Color(0xFF4A148C)],
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

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});
  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  String _selectedCategory = 'Todas';
  final List<String> _categories = [
    'Todas',
    'Linguagens',
    'Frameworks',
    'Ferramentas',
    'Design',
    'Metodologias',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredSkills = _selectedCategory == 'Todas'
        ? habilidades
        : habilidades
              .where((skill) => skill.categoria == _selectedCategory)
              .toList();

    return Scaffold(
      backgroundColor: const Color(0xff0a192f),
      body: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground()),
          const Positioned.fill(child: AnimatedParticleBackground()),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildFilters()),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 420,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.5,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final skill = filteredSkills[index];
                    return _SkillCard(skill: skill)
                        .animate()
                        .fadeIn(delay: (100 * (index % 3)).ms)
                        .slideY(begin: 0.2, duration: 400.ms);
                  }, childCount: filteredSkills.length),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF64FFDA), Color(0xFF8892B0)],
                ).createShader(bounds),
                child: const Text(
                  'Minhas Habilidades',
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
            'Um arsenal de tecnologias e metodologias que utilizo para construir experiências digitais incríveis.',
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

  Widget _buildFilters() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return _HoveringFilterChip(
            label: category,
            isSelected: _selectedCategory == category,
            onSelected: (_) => setState(() => _selectedCategory = category),
          );
        },
      ),
    );
  }
}

class _HoveringFilterChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  const _HoveringFilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  State<_HoveringFilterChip> createState() => __HoveringFilterChipState();
}

class __HoveringFilterChipState extends State<_HoveringFilterChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0, _isHovered && !widget.isSelected ? -3.0 : 0.0),
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ChoiceChip(
            label: Text(widget.label),
            labelStyle: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.grey[300],
              fontWeight: FontWeight.w500,
            ),
            selected: widget.isSelected,
            onSelected: widget.onSelected,
            backgroundColor: Colors.white.withOpacity(0.1),
            selectedColor: Colors.blueAccent.withOpacity(0.8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: widget.isSelected
                    ? Colors.blueAccent
                    : Colors.white.withOpacity(0.2),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          ),
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final Habilidade skill;
  const _SkillCard({required this.skill});
  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.skill.icone,
                  size: 32,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.skill.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.skill.descricao,
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.skill.destaque)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber.withOpacity(0.5)),
                  ),
                  child: const Text(
                    'DESTAQUE',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(widget.skill.nivel * 100).round()}% Proficiência',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value:
                          _animationController
                              .drive(CurveTween(curve: Curves.easeOut))
                              .value *
                          widget.skill.nivel,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      color: Colors.blueAccent,
                      minHeight: 10,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
