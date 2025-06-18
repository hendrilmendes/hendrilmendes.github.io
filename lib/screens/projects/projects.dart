// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:folio/configs/app_theme.dart';
import 'package:folio/models/projects.dart';
import 'package:url_launcher/url_launcher.dart';
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

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});
  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _selectedCategory = 'Todos';
  final List<String> _categories = [
    'Todos',
    'Aplicativos',
    'Redes Sociais',
    'Ferramentas',
    'Dashboards',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProjects = _selectedCategory == 'Todos'
        ? projetos
        : projetos.where((p) => p.categoria == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppTheme.cBackground,
      body: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground()),
          const Positioned.fill(child: AnimatedParticleBackground()),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context)),
              SliverToBoxAdapter(child: _buildFilters()),
              SliverPadding(
                padding: const EdgeInsets.all(24.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 380,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final projeto = filteredProjects[index];
                    return _ProjectCard(projeto: projeto)
                        .animate()
                        .fadeIn(duration: 600.ms, delay: (100 * (index % 4)).ms)
                        .slideY(begin: 0.2, curve: Curves.easeOutCubic);
                  }, childCount: filteredProjects.length),
                ),
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
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppTheme.cPrimary, AppTheme.cSecondary],
                ).createShader(bounds),
                child: const Text(
                  'Portfólio de Projetos',
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
            'Explore uma seleção dos meus trabalhos, cada um com seus próprios desafios e aprendizados.',
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: SizedBox(
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
              color: widget.isSelected ? Colors.black : AppTheme.cSecondary,
              fontWeight: FontWeight.w500,
            ),
            selected: widget.isSelected,
            onSelected: widget.onSelected,
            backgroundColor: Colors.white.withOpacity(0.1),
            selectedColor: AppTheme.cPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: widget.isSelected
                    ? AppTheme.cPrimary
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

class _ProjectCard extends StatefulWidget {
  final Projeto projeto;
  const _ProjectCard({required this.projeto});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  Future<void> _abrirProjeto(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Não foi possível abrir a URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _abrirProjeto(widget.projeto.urlProject),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                scale: _isHovered ? 1.05 : 1.0,
                child: Image.network(
                  widget.projeto.imagemUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.5, 1.0],
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isHovered ? 1.0 : 0.0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
              ),
              _buildCardContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: _isHovered ? 1.0 : 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.projeto.descricao,
                    style: const TextStyle(color: Colors.white, height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.projeto.tags
                        .map(
                          (tag) => Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: AppTheme.cPrimary.withOpacity(0.8),
                            labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          Text(
            widget.projeto.titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 10, color: Colors.black)],
            ),
          ),
        ],
      ),
    );
  }
}
