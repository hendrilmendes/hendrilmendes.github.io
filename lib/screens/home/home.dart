// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:folio/screens/curriculum/curriculum.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _titles = [
    'Desenvolvedor Mobile',
    'Engenheiro de Computação',
    'Engenheiro de Software',
    'Técnico em Informática',
    'Entusiasta de UI/UX',
  ];

  int _currentTitleIndex = 0;
  Timer? _timer;
  bool _isHovered = false;

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
      setState(() {
        _currentTitleIndex = (_currentTitleIndex + 1) % _titles.length;
      });
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: CustomScrollView(
        slivers: [
          // AppBar com efeito de parallax
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Hendril Mendes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Image.network(
                'https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.file_download, color: Colors.white),
                onPressed: () => _showCurriculum(context),
              ),
            ],
          ),

          // Conteúdo principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Seção de apresentação
                  _buildProfileSection(),
                  const SizedBox(height: 40),

                  // Seção de títulos rotativos
                  _buildTitleSection(),
                  const SizedBox(height: 40),

                  // Seção sobre mim
                  _buildAboutSection(),
                  const SizedBox(height: 40),

                  // Seção de habilidades em destaque
                  _buildSkillsHighlight(),
                  const SizedBox(height: 40),

                  // Seção de redes sociais
                  _buildSocialMediaSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blueAccent, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  'https://avatars.githubusercontent.com/u/28198780?v=4',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Oi, eu sou o Hendril! 👋',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Transformando ideias em realidade através do código',
          style: TextStyle(color: Colors.grey[400], fontSize: 18),
        ),
      ],
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildTitleSection() {
    return SizedBox(
      height: 80,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: Container(
          key: ValueKey<int>(_currentTitleIndex),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.withOpacity(0.2),
                Colors.purpleAccent.withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.blueAccent.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Text(
            _titles[_currentTitleIndex],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey[850]!, Colors.grey[800]!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sobre Mim',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Natural de Minaçu-GO, minha jornada na tecnologia começou na infância, impulsionada pelo fascínio pelo seu poder transformador. '
            'O que era curiosidade se tornou uma busca contínua por inovação, consolidando-me como um profissional multidisciplinar e focado em excelência.\n\n'
            'Minha atuação é guiada por dois pilares fundamentais:\n'
            '✅ Paixão por tecnologia, sempre atento aos detalhes e às tendências emergentes\n'
            '✅ Aprendizado contínuo, explorando novas fronteiras do conhecimento\n\n'
            'Meu propósito é claro: utilizar a tecnologia para transformar problemas em soluções e gerar impacto positivo no mundo.',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _showCurriculum(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Ver Currículo Completo'),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildSkillsHighlight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilidades em Destaque',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Tecnologias que domino e utilizo no meu dia a dia',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildSkillChip('Flutter', Icons.phone_android),
            _buildSkillChip('Dart', Icons.code),
            _buildSkillChip('Firebase', Icons.cloud),
            _buildSkillChip('UI/UX', Icons.design_services),
            _buildSkillChip('Git', Icons.code),
            _buildSkillChip('Responsive Design', Icons.screen_rotation),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill, IconData icon) {
    return Chip(
      avatar: Icon(icon, color: Colors.blueAccent),
      label: Text(skill, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey[800],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildSocialMediaSection() {
    return Column(
      children: [
        const Text(
          'Conecte-se Comigo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Vamos conversar sobre projetos, oportunidades ou colaborações',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(
              MdiIcons.github,
              'GitHub',
              'https://github.com/hendrilmendes',
            ),
            const SizedBox(width: 20),
            _buildSocialIcon(
              MdiIcons.linkedin,
              'LinkedIn',
              'https://linkedin.com/in/hendrilmendes',
            ),
            const SizedBox(width: 20),
            _buildSocialIcon(
              MdiIcons.telegram,
              'Telegram',
              'https://t.me/hendril_mendes',
            ),
            const SizedBox(width: 20),
            _buildSocialIcon(
              MdiIcons.instagram,
              'Instagram',
              'https://instagram.com/hendril_mendes',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String tooltip, String url) {
    return IconButton(
      iconSize: 36,
      icon: Icon(icon),
      color: Colors.white,
      hoverColor: Colors.blueAccent,
      tooltip: tooltip,
      onPressed: () => _launchURL(url),
    );
  }

  void _showCurriculum(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900, maxHeight: 700),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const CurriculumScreen(),
          ),
        );
      },
    );
  }
}
