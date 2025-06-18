// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:folio/screens/curriculum/curriculum.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

// --- WIDGETS DE ANIMAÇÃO E EFEITOS (NOVOS E MELHORADOS) ---

// NOVO: Fundo "Aurora" suavemente animado
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
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xFF0D47A1), Color(0xFF4A148C)],
              begin: _topAlignmentAnimation.value,
              end: _bottomAlignmentAnimation.value,
            ),
          ),
        );
      },
    );
  }
}

class Particle {
  Offset position;
  Offset speed;
  Color color;
  double radius;
  Particle({
    required this.position,
    required this.speed,
    this.color = Colors.white,
    this.radius = 1.5,
  });
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
    // OTIMIZAÇÃO: Reduzido o número de partículas para melhor performance
    const particleCount = 35;
    particles = List.generate(particleCount, (index) {
      return Particle(
        position: Offset(
          _random.nextDouble() * size.width,
          _random.nextDouble() * size.height,
        ),
        speed: Offset(
          (_random.nextDouble() - 0.5) * 0.4,
          (_random.nextDouble() - 0.5) * 0.4,
        ),
      );
    });
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
      _paint.color = p.color.withOpacity(0.8);
      canvas.drawCircle(p.position, p.radius, _paint);
      for (var other in particles) {
        final distance = (p.position - other.position).distance;
        if (distance < connectionDistance) {
          _paint.color = p.color.withOpacity(
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
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _titles = [
    'Engenheiro de Computação',
    'Desenvolvedor Web & Mobile',
    'Técnico em Tecnologia da Informação',
    'Entusiasta de UI/UX',
    'Resolvedor de Problemas',
  ];
  int _currentTitleIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTitleRotation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTitleRotation() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (mounted) {
        setState(
          () => _currentTitleIndex = (_currentTitleIndex + 1) % _titles.length,
        );
      }
    });
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Não foi possível abrir a URL: $url';
  }

  void _showCurriculum(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900, maxHeight: 700),
            child: GlassmorphicCard(child: CurriculumScreen()),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a192f),
      body: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground()),
          const Positioned.fill(child: AnimatedParticleBackground()),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeroSection()),
              SliverToBoxAdapter(child: _buildContentLayout()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/28198780?v=4',
                    width: 150,
                    height: 150,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 900.ms)
              .scale(duration: 700.ms, curve: Curves.easeOutBack),

          const SizedBox(height: 30),

          ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF64FFDA), Color(0xFF8892B0)],
                ).createShader(bounds),
                child: const Text(
                  'Hendril Mendes',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black26)],
                  ),
                ),
              )
              .animate(delay: 300.ms)
              .fadeIn()
              .slideY(begin: 0.5, curve: Curves.easeOutCubic),

          const SizedBox(height: 15),

          _buildTitleSection(),
          const SizedBox(height: 30),

          _buildSocialMediaRow()
              .animate(delay: 700.ms)
              .fadeIn()
              .slideY(begin: 0.8, curve: Curves.easeOutCubic),
          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.download_rounded, size: 20),
                label: const Text('Ver Currículo'),
                onPressed: () => _showCurriculum(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => _launchURL("https://github.com/hendrilmendes"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 18,
                  ),
                  side: const BorderSide(color: Colors.blueAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('GitHub'),
              ),
            ],
          ).animate(delay: 900.ms).fadeIn(),
        ],
      ),
    );
  }

  Widget _buildContentLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 950) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: GlassmorphicCard(child: _buildAboutContent()),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 2,
                  child: GlassmorphicCard(child: _buildSkillsContent()),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                GlassmorphicCard(child: _buildAboutContent()),
                const SizedBox(height: 40),
                GlassmorphicCard(child: _buildSkillsContent()),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sobre Mim',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Minha jornada na tecnologia começou na infância, impulsionada pelo fascínio pelo seu poder transformador. O que era curiosidade se tornou uma busca contínua por inovação e excelência.',
          style: TextStyle(color: Colors.grey[300], fontSize: 16, height: 1.6),
        ),
        const SizedBox(height: 20),
        const Divider(color: Colors.white24),
        const SizedBox(height: 20),
        _buildInfoRow(
          Icons.check_circle_outline,
          'Paixão por criar soluções elegantes',
        ),
        const SizedBox(height: 12),
        _buildInfoRow(
          Icons.lightbulb_outline,
          'Aprendizado contínuo e adaptabilidade',
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 22),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[300], fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilidades',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Tecnologias que domino e utilizo para transformar ideias em realidade.',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _HoveringSkillChip('Flutter'),
            _HoveringSkillChip('Dart'),
            _HoveringSkillChip('Firebase'),
            _HoveringSkillChip('UI/UX Design'),
            _HoveringSkillChip('Git'),
            _HoveringSkillChip('SQL'),
          ],
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _HoveringSkillChip(String skill) {
    return Animate(
      effects: const [
        ShimmerEffect(
          delay: Duration(seconds: 2),
          duration: Duration(milliseconds: 1500),
          color: Colors.white10,
        ),
      ],
      child: Chip(
        label: Text(
          skill,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blueAccent.withOpacity(0.2),
        side: BorderSide(color: Colors.blueAccent.withOpacity(0.5)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _buildTitleSection() {
    return SizedBox(
      height: 40,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: Text(
          _titles[_currentTitleIndex],
          key: ValueKey<int>(_currentTitleIndex),
          style: const TextStyle(
            color: Color(0xFF64FFDA),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialMediaRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(MdiIcons.github, 'https://github.com/hendrilmendes'),
        _buildSocialIcon(
          MdiIcons.linkedin,
          'https://linkedin.com/in/hendril-mendes',
        ),
        _buildSocialIcon(MdiIcons.telegram, 'https://t.me/hendril_mendes'),
        _buildSocialIcon(
          MdiIcons.instagram,
          'https://instagram.com/hendril_mendes',
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon),
      color: Colors.grey[400],
      iconSize: 28,
      splashRadius: 25,
      hoverColor: Colors.blueAccent.withOpacity(0.1),
      onPressed: () => _launchURL(url),
    );
  }
}
