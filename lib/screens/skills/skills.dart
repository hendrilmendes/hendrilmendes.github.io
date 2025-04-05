// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:folio/models/habilidades.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    final filteredSkills =
        _selectedCategory == 'Todas'
            ? habilidades
            : habilidades
                .where((skill) => skill.categoria == _selectedCategory)
                .toList();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Minhas Habilidades',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Image.network(
                'https://images.unsplash.com/photo-1498050108023-c5249f4df085?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2072&q=80',
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Competências Técnicas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Conhecimentos e habilidades que desenvolvi ao longo da minha carreira',
                    style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  ),
                  const SizedBox(height: 24),

                  // Filtros por categoria
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              category,
                              style: TextStyle(
                                color:
                                    _selectedCategory == category
                                        ? Colors.white
                                        : Colors.grey[300],
                              ),
                            ),
                            selected: _selectedCategory == category,
                            selectedColor: Colors.blueAccent,
                            backgroundColor: Colors.grey[800],
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory =
                                    selected ? category : 'Todas';
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Grid de habilidades
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 400,
                                  crossAxisSpacing: 24,
                                  mainAxisSpacing: 24,
                                  childAspectRatio:
                                      constraints.maxWidth > 1000 ? 1.2 : 1.5,
                                ),
                            itemCount: filteredSkills.length,
                            itemBuilder: (context, index) {
                              final skill = filteredSkills[index];
                              return _SkillCard(skill: skill)
                                  .animate()
                                  .fadeIn(delay: (100 * index).ms)
                                  .slideY(begin: 0.1, duration: 500.ms);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
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
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(_isHovered ? 1.03 : 1.0),
        child: Card(
          elevation: _isHovered ? 10 : 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.grey[850],
          shadowColor:
              _isHovered ? Colors.blueAccent.withOpacity(0.5) : Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                      child: Text(
                        widget.skill.nome,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (widget.skill.destaque)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
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
                const SizedBox(height: 16),
                Text(
                  widget.skill.descricao,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
                const SizedBox(height: 24),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(widget.skill.nivel * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _getExperienceLevel(widget.skill.nivel),
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value:
                              _animationController.value * widget.skill.nivel,
                          backgroundColor: Colors.grey[800],
                          color: Colors.blueAccent,
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    );
                  },
                ),
                if (_isHovered) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        widget.skill.tags
                            .map(
                              (tag) => Chip(
                                label: Text(
                                  tag,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                backgroundColor: Colors.blueAccent.withOpacity(
                                  0.1,
                                ),
                                visualDensity: VisualDensity.compact,
                              ),
                            )
                            .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getExperienceLevel(double level) {
    if (level >= 0.8) return 'Especialista';
    if (level >= 0.6) return 'Avançado';
    if (level >= 0.4) return 'Intermediário';
    return 'Iniciante';
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
