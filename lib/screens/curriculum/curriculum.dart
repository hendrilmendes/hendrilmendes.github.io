// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:folio/configs/app_theme.dart';
import 'package:folio/data/curriculum_data.dart';
import 'package:folio/widgets/animated_particle_background.dart';
import 'package:folio/widgets/aurora_background.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CurriculumScreen extends StatelessWidget {
  const CurriculumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const AuroraBackground(),
          const AnimatedParticleBackground(),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppTheme.cBackground.withOpacity(0.7),
                pinned: true,
                floating: true,
                automaticallyImplyLeading: false,
                elevation: 0,
                actions: [
                  const CurriculumOptionButton(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    tooltip: 'Fechar',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 80.0),
                sliver: SliverToBoxAdapter(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 40,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: const _CurriculumContent(),
                      ),
                    ),
                  ).animate().fadeIn(duration: 500.ms),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CurriculumContent extends StatelessWidget {
  const _CurriculumContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 40),
        const _SectionTitle(title: 'Contato'),
        const SizedBox(height: 16),
        _ContactInfo(),
        const SizedBox(height: 30),
        const _SectionTitle(title: 'Resumo Profissional'),
        const SizedBox(height: 16),
        const Text(
          CurriculumData.resumoProfissional,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: AppTheme.cSecondary,
          ),
        ),
        const SizedBox(height: 30),
        const _SectionTitle(title: 'Formação Acadêmica'),
        const SizedBox(height: 16),
        _BulletList(items: CurriculumData.formacao),
        const SizedBox(height: 30),
        const _SectionTitle(title: 'Experiência Profissional'),
        const SizedBox(height: 16),
        _BulletListWithSub(items: CurriculumData.experiencia),
        const SizedBox(height: 30),
        const _SectionTitle(title: 'Cursos e Certificações'),
        const SizedBox(height: 16),
        _BulletList(items: CurriculumData.cursos),
        const SizedBox(height: 30),
        const _SectionTitle(title: 'Habilidades Técnicas'),
        const SizedBox(height: 16),
        _CategorizedSkills(skillsMap: CurriculumData.habilidades),
        const SizedBox(height: 30),
        const _SectionTitle(title: 'Idiomas'),
        const SizedBox(height: 16),
        _BulletList(items: CurriculumData.idiomas),
        const SizedBox(height: 30),
        const _SectionTitle(title: 'Informações Adicionais'),
        const SizedBox(height: 16),
        Text(
          CurriculumData.infoAdicional,
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: AppTheme.cSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, AppTheme.cSecondary],
          ).createShader(bounds),
          child: const Text(
            CurriculumData.nome,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          CurriculumData.titulo,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: AppTheme.cSecondary,
          ),
        ),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: CurriculumData.contato.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RichText(
            text: TextSpan(
              text: '${entry.key}: ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              children: [
                TextSpan(
                  text: entry.value,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppTheme.cSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppTheme.cPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "•  ",
                    style: TextStyle(
                      color: AppTheme.cPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: AppTheme.cSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _BulletListWithSub extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const _BulletListWithSub({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((map) {
        final title = map['title'] as String;
        final subitems = List<String>.from(map['subitems'] ?? []);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: subitems
                      .map(
                        (subitem) => Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "–  ",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.cSecondary,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                subitem,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  color: AppTheme.cSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _CategorizedSkills extends StatelessWidget {
  final Map<String, List<String>> skillsMap;
  const _CategorizedSkills({required this.skillsMap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: skillsMap.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${entry.key}:',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                entry.value.join(' • '),
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: AppTheme.cSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class CurriculumOptionButton extends StatelessWidget {
  const CurriculumOptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 28,
      tooltip: "Opções do Currículo",
      icon: const Icon(MdiIcons.dotsVertical, color: Colors.white),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              backgroundColor: const Color(0xff1a2b47).withOpacity(0.95),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.picture_as_pdf_rounded,
                      color: AppTheme.cPrimary,
                    ),
                    title: const Text(
                      "Salvar como PDF",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      Navigator.of(dialogContext).pop();
                      final messenger = ScaffoldMessenger.of(context);

                      try {
                        messenger.showSnackBar(
                          const SnackBar(content: Text('Gerando PDF...')),
                        );

                        final pdfBytes = await _generatePdf(
                          pw.PdfPageFormat.a4,
                        );

                        messenger.hideCurrentSnackBar();

                        await Printing.sharePdf(
                          bytes: pdfBytes,
                          filename: 'curriculo_hendril_mendes.pdf',
                        );
                      } catch (e) {
                        messenger.hideCurrentSnackBar();
                        messenger.showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 10),
                            backgroundColor: Colors.red.shade800,
                            content: Text('ERRO AO GERAR PDF: $e'),
                          ),
                        );
                      }
                    },
                  ),
                  const Divider(color: Colors.white24, height: 1),
                  ListTile(
                    leading: const Icon(
                      Icons.print_rounded,
                      color: AppTheme.cPrimary,
                    ),
                    title: const Text(
                      "Imprimir",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      Navigator.of(dialogContext).pop();
                      try {
                        await Printing.layoutPdf(
                          onLayout: (format) => _generatePdf(format),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 10),
                            backgroundColor: Colors.red.shade800,
                            content: Text('ERRO AO IMPRIMIR: $e'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

const pw.PdfColor darkColor = pw.PdfColor.fromInt(0xFF2C3E50);
const pw.PdfColor lightColor = pw.PdfColor.fromInt(0xFFFFFFFF);
const pw.PdfColor accentColor = pw.PdfColor.fromInt(0xFF3498DB);
const pw.PdfColor textColor = pw.PdfColor.fromInt(0xFF34495E);
const pw.PdfColor lightTextColor = pw.PdfColor.fromInt(0xFFBDC3C7);

const double _leftColumnWidth = 180.0;

Future<Uint8List> _generatePdf(pw.PdfPageFormat format) async {
  final pdf = pw.Document(version: pw.PdfVersion.pdf_1_5, compress: true);

  final profileImageBytes = await rootBundle.load('assets/profile.jpeg');
  final profileImage = pw.MemoryImage(profileImageBytes.buffer.asUint8List());
  final font = await PdfGoogleFonts.openSansRegular();
  final boldFont = await PdfGoogleFonts.openSansBold();

  pdf.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: format,
        margin: pw.EdgeInsets.zero,
        theme: pw.ThemeData.withFont(base: font, bold: boldFont),
        buildBackground: (context) {
          return pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Este é o conteúdo que antes estava no `header`
              _buildLeftColumnContent(profileImage),
              // Deixa o resto da página com fundo branco
              pw.Expanded(child: pw.Container(color: pw.PdfColors.white)),
            ],
          );
        },
      ),

      build: (context) => [
        pw.Padding(
          padding: const pw.EdgeInsets.only(
            left: _leftColumnWidth + 30,
            right: 30,
            top: 40,
            bottom: 40,
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: _buildRightColumnContent(),
          ),
        ),
      ],
    ),
  );

  return pdf.save();
}

pw.Widget _buildLeftColumnContent(pw.MemoryImage profileImage) {
  return pw.Container(
    width: _leftColumnWidth,
    height: pw.PdfPageFormat.a4.height,
    color: darkColor,
    padding: const pw.EdgeInsets.all(20),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Center(
          child: pw.ClipOval(
            child: pw.Container(
              width: 120,
              height: 120,
              child: pw.Image(profileImage, fit: pw.BoxFit.cover),
            ),
          ),
        ),
        pw.SizedBox(height: 30),

        _buildSectionTitleLeft('CONTATO'),
        ...CurriculumData.contato.entries.map(
          (e) => _buildContactRow(e.key, e.value),
        ),
        pw.SizedBox(height: 20),

        _buildSectionTitleLeft('IDIOMAS'),
        ...CurriculumData.idiomas.map(
          (lang) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 5),
            child: pw.Text(
              lang,
              style: const pw.TextStyle(color: lightTextColor, fontSize: 10),
            ),
          ),
        ),
      ],
    ),
  );
}

List<pw.Widget> _buildRightColumnContent() {
  return [
    pw.Text(
      CurriculumData.nome,
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 28,
        color: darkColor,
      ),
    ),
    pw.SizedBox(height: 4),
    pw.Text(
      CurriculumData.titulo,
      style: pw.TextStyle(
        fontSize: 16,
        color: textColor,
        fontStyle: pw.FontStyle.italic,
      ),
    ),
    pw.SizedBox(height: 30),

    _buildSectionTitleRight('RESUMO PROFISSIONAL'),
    pw.Text(
      '${CurriculumData.resumoProfissional}\n\n${CurriculumData.infoAdicional}',
      textAlign: pw.TextAlign.justify,
      style: const pw.TextStyle(
        fontSize: 10,
        color: textColor,
        lineSpacing: 2.5,
      ),
    ),
    pw.SizedBox(height: 25),

    _buildSectionTitleRight('EXPERIÊNCIA PROFISSIONAL'),
    ...CurriculumData.experiencia.map((e) => _buildExperienceItem(e)),
    pw.SizedBox(height: 25),

    _buildSectionTitleRight('HABILIDADES TÉCNICAS'),
    ...CurriculumData.habilidades.entries.map(
      (e) => _buildSkillCategoryRight(e.key, e.value),
    ),
    pw.SizedBox(height: 25),

    _buildSectionTitleRight('FORMAÇÃO ACADÊMICA'),
    ...CurriculumData.formacao.map((e) => _buildEducationItem(e)),
    pw.SizedBox(height: 25),

    _buildSectionTitleRight('CURSOS E CERTIFICAÇÕES'),
    ...CurriculumData.cursos.map((e) => _buildCourseItem(e)),
  ];
}

pw.Widget _buildSectionTitleLeft(String title) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          color: lightColor,
          fontWeight: pw.FontWeight.bold,
          fontSize: 12,
        ),
      ),
      pw.Container(
        margin: const pw.EdgeInsets.only(top: 4, bottom: 12),
        height: 2,
        width: 30,
        color: accentColor,
      ),
    ],
  );
}

pw.Widget _buildContactRow(String title, String value) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 6),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            color: lightColor,
            fontWeight: pw.FontWeight.bold,
            fontSize: 10,
          ),
        ),
        pw.Text(
          value,
          style: const pw.TextStyle(color: lightTextColor, fontSize: 10),
        ),
      ],
    ),
  );
}

pw.Widget _buildSectionTitleRight(String title) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          color: darkColor,
          fontWeight: pw.FontWeight.bold,
          fontSize: 14,
        ),
      ),
      pw.Container(
        margin: const pw.EdgeInsets.only(top: 4, bottom: 12),
        height: 2,
        width: 40,
        color: accentColor,
      ),
    ],
  );
}

pw.Widget _buildExperienceItem(Map<String, dynamic> item) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 15),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          item['title'],
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            fontSize: 11,
            color: textColor,
          ),
        ),
        pw.SizedBox(height: 6),
        ...List<String>.from(item['subitems']).map(
          (sub) => pw.Padding(
            padding: const pw.EdgeInsets.only(left: 8, bottom: 3),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '• ',
                  style: const pw.TextStyle(color: accentColor, fontSize: 11),
                ),
                pw.Expanded(
                  child: pw.Text(
                    sub,
                    textAlign: pw.TextAlign.justify,
                    style: const pw.TextStyle(fontSize: 10, color: textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildSkillCategoryRight(String category, List<String> skills) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 10),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 90,
          child: pw.Text(
            '$category:',
            style: pw.TextStyle(
              fontSize: 10,
              fontWeight: pw.FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            skills.join(' • '),
            style: const pw.TextStyle(fontSize: 10, color: textColor),
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildEducationItem(String item) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 5),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '• ',
          style: const pw.TextStyle(color: accentColor, fontSize: 11),
        ),
        pw.Expanded(
          child: pw.Text(
            item,
            style: const pw.TextStyle(fontSize: 10, color: textColor),
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildCourseItem(String item) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 5),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          '• ',
          style: const pw.TextStyle(color: accentColor, fontSize: 11),
        ),
        pw.Expanded(
          child: pw.Text(
            item,
            style: const pw.TextStyle(fontSize: 10, color: textColor),
          ),
        ),
      ],
    ),
  );
}
