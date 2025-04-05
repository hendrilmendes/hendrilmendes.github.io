// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:folio/models/projects.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    final filteredProjects =
        _selectedCategory == 'Todos'
            ? projetos
            : projetos.where((proj) {
              if (_selectedCategory == 'Aplicativos') {
                return proj.titulo == 'Shop' || proj.titulo == 'News-Droid';
              } else if (_selectedCategory == 'Redes Sociais') {
                return proj.titulo == 'Pulse Messenger';
              } else if (_selectedCategory == 'Ferramentas') {
                return proj.titulo == 'Calculadora' || proj.titulo == 'Tarefas';
              } else if (_selectedCategory == 'Dashboards') {
                return proj.titulo == 'Shop Dashboard';
              }
              return false;
            }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Meus Projetos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Image.network(
                'https://images.unsplash.com/photo-1467232004584-a241de8bcf5d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2069&q=80',
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
                    'Portfólio Criativo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore meus trabalhos e projetos desenvolvidos com dedicação e inovação',
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
                                    selected ? category : 'Todos';
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Grid de projetos
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
                                      constraints.maxWidth > 1000 ? 0.95 : 1.1,
                                ),
                            itemCount: filteredProjects.length,
                            itemBuilder: (context, index) {
                              final projeto = filteredProjects[index];
                              return _ProjectCard(projeto: projeto)
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

class _ProjectCard extends StatefulWidget {
  final Projeto projeto;

  const _ProjectCard({required this.projeto});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isFeatured =
        widget.projeto.titulo == 'News-Droid' ||
        widget.projeto.titulo == 'Tá na Lista';

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _abrirProjeto(widget.projeto.urlProject),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..scale(_isHovered ? 1.03 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[850],
            boxShadow:
                _isHovered
                    ? [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ]
                    : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem do projeto
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      widget.projeto.imagemUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          height: 180,
                          color: Colors.grey[800],
                          child: Center(
                            child: CircularProgressIndicator(
                              value:
                                  progress.expectedTotalBytes != null
                                      ? progress.cumulativeBytesLoaded /
                                          progress.expectedTotalBytes!
                                      : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            height: 180,
                            color: Colors.grey[800],
                            child: const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          ),
                    ),
                  ),
                  if (isFeatured)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'DESTAQUE',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (_isHovered)
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'VISUALIZAR PROJETO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.projeto.titulo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.open_in_new,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                          onPressed:
                              () => _abrirProjeto(widget.projeto.urlProject),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.projeto.descricao,
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          _getTechTags(widget.projeto.titulo)
                              .map(
                                (tech) => Chip(
                                  label: Text(
                                    tech,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  backgroundColor: Colors.blueAccent
                                      .withOpacity(0.1),
                                  visualDensity: VisualDensity.compact,
                                ),
                              )
                              .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getTechTags(String projectTitle) {
    switch (projectTitle) {
      case 'Pulse Messenger':
        return ['Flutter', 'Firebase', 'Chat'];
      case 'Shop Dashboard':
        return ['Flutter', 'Admin', 'Analytics'];
      case 'News-Droid':
        return ['Flutter', 'Blogger API', 'Android'];
      case 'Tarefas':
        return ['Flutter', 'Firebase', 'Produtividade'];
      case 'Calculadora':
        return ['Flutter', 'Dart', 'Matemática'];
      case 'Wally':
        return ['Flutter', 'IA', 'Assistente'];
      case 'Shop':
        return ['Flutter', 'E-commerce', 'Firebase'];
      default:
        return ['Flutter', 'Mobile'];
    }
  }

  Future<void> _abrirProjeto(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }
}
