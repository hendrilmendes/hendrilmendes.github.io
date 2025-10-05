// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:folio/configs/app_theme.dart';
import 'package:folio/models/educacao.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:folio/widgets/animated_particle_background.dart';
import 'package:folio/widgets/aurora_background.dart';
import 'package:folio/widgets/glassmorphic_card.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            )
            // --- ANIMAÇÃO CORRIGIDA ---
            // Adicionado um efeito de 'scale' para criar um pulso.
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(
              duration: 800.ms,
              curve: Curves.easeInOut,
              begin: const Offset(1, 1),
              end: const Offset(1.15, 1.15),
            ),
      ],
    );
  }
}

class EducationCard extends StatelessWidget {
  final Education education;
  const EducationCard({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
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
