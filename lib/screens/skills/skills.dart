// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:folio/models/habilidades.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:folio/widgets/animated_particle_background.dart';
import 'package:folio/widgets/aurora_background.dart';
import 'package:folio/widgets/glassmorphic_card.dart';

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
