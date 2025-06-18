// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:folio/configs/app_theme.dart';
import 'package:folio/screens/contact/contact.dart'; // Remova se 'AuroraBackground' e 'AnimatedParticleBackground' estiverem em outro lugar
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CurriculumData {
  static const String nome = 'Hendril Mendes Ribeiro';
  static const String titulo =
      'Desenvolvedor de Software | Técnico em Informática';

  static const Map<String, String> contato = {
    'E-mail': 'hendrilmendes2015@gmail.com',
    'Telefone': '+55 65 99361-1847',
    'Local': 'Jauru, MT, Brasil',
    'Portfólio': 'hendrilmendes.github.io',
    'LinkedIn': 'linkedin.com/in/hendril-mendes',
  };

  static const String objetivo =
      'Atuar na área de Tecnologia da Informação, contribuindo com minhas habilidades em manutenção de sistemas, suporte técnico, administração de redes e desenvolvimento de soluções (web e mobile), agregando valor à equipe e à empresa.';

  static const List<String> formacao = [
    'Engenharia da Computação: Universidade Cruzeiro do Sul, Jauru-MT (Em andamento)',
  ];

  static const List<Map<String, dynamic>> experiencia = [
    {
      'title':
          'Técnico em Informática – NetSYS Internet & Informática (2018 – Atual)',
      'subitems': [
        'Análise e otimização de sistemas, realizando diagnóstico e reparo de hardware e software para maximizar a performance e a confiabilidade.',
        'Infraestrutura de redes, incluindo implantação, configuração e manutenção para ambientes empresariais, garantindo segurança e alta disponibilidade.',
        'Suporte técnico especializado, oferecendo atendimento ágil e soluções eficazes para clientes, assegurando a continuidade e eficiência operacional',
      ],
    },
  ];

  static const List<String> cursos = [
    'Startto.dev (2023) - Criação de apps utilizando Flutter.',
    'SENAI (2022) - Tecnologia da Informação e Comunicação.',
    'Microsoft (2022) - HTML, CSS, JavaScript.',
    'Didática Tech (2022) - Python.',
    'NetSYS Internet & Informática (2017) - Windows 7 e Windows 8, Microsoft Office, CorelDraw X7, Photoshop CC.',
    'Brasil Treinamentos (2015) - Manutenção e Reparação de Microcomputadores e Redes.',
  ];

  static const List<String> habilidades = [
    'Suporte Técnico e Atendimento: Atendimento ao cliente e resolução de problemas técnicos.',
    'Manutenção de Hardware: Reparação e manutenção de microcomputadores.',
    'Administração de Redes: Configuração e gerenciamento de redes e servidores.',
    'Desenvolvimento: HTML, CSS, JavaScript, Python e desenvolvimento de apps com Flutter/Dart.',
    'Ferramentas: Microsoft Office, VMWare, CorelDraw, Photoshop; familiaridade com Windows, macOS e Linux.',
  ];

  static const List<String> idiomas = [
    'Inglês: Intermediário para leitura técnica e comunicação.',
    'Espanhol: Intermediário para leitura técnica e comunicação.',
  ];

  static const String infoAdicional =
      'Tenho 24 anos e busco constante evolução pessoal e profissional, com facilidade de aprendizado e adaptação a novas tecnologias.';
}

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

        const _SectionTitle(title: 'Objetivo Profissional'),
        const SizedBox(height: 16),
        const Text(
          CurriculumData.objetivo,
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: AppTheme.cSecondary,
          ),
        ),
        const SizedBox(height: 30),

        const _SectionTitle(title: 'Formação Acadêmica'),
        const SizedBox(height: 16),
        const _BulletList(items: CurriculumData.formacao),
        const SizedBox(height: 30),

        const _SectionTitle(title: 'Experiência Profissional'),
        const SizedBox(height: 16),
        const _BulletListWithSub(items: CurriculumData.experiencia),
        const SizedBox(height: 30),

        const _SectionTitle(title: 'Cursos e Certificações'),
        const SizedBox(height: 16),
        const _BulletList(items: CurriculumData.cursos),
        const SizedBox(height: 30),

        const _SectionTitle(title: 'Habilidades Técnicas'),
        const SizedBox(height: 16),
        const _BulletList(items: CurriculumData.habilidades),
        const SizedBox(height: 30),

        const _SectionTitle(title: 'Idiomas'),
        const SizedBox(height: 16),
        const _BulletList(items: CurriculumData.idiomas),
        const SizedBox(height: 30),

        const _SectionTitle(title: 'Informações Adicionais'),
        const SizedBox(height: 16),
        const Text(
          CurriculumData.infoAdicional,
          style: TextStyle(
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
        const Text(
          CurriculumData.titulo,
          textAlign: TextAlign.center,
          style: TextStyle(
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
          builder: (BuildContext context) {
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
                      final pdfBytes = await _generatePdf(pw.PdfPageFormat.a4);
                      await Printing.sharePdf(
                        bytes: pdfBytes,
                        filename: 'curriculo_hendril_mendes.pdf',
                      );
                      Navigator.of(context).pop();
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
                      await Printing.layoutPdf(
                        onLayout: (format) => _generatePdf(format),
                      );
                      Navigator.of(context).pop();
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

Future<Uint8List> _generatePdf(pw.PdfPageFormat format) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: format,
      theme: pw.ThemeData.withFont(
        base: await PdfGoogleFonts.openSansRegular(),
        bold: await PdfGoogleFonts.openSansBold(),
      ),
      build: (pw.Context context) {
        return [
          _buildPdfHeader(),
          pw.SizedBox(height: 20),
          _buildPdfSectionTitle('Contato'),
          _buildPdfContactInfo(),
          pw.SizedBox(height: 15),

          _buildPdfSectionTitle('Objetivo Profissional'),
          _buildPdfParagraph(CurriculumData.objetivo),
          pw.SizedBox(height: 15),

          _buildPdfSectionTitle('Formação Acadêmica'),
          _buildPdfBulletList(CurriculumData.formacao),
          pw.SizedBox(height: 15),

          _buildPdfSectionTitle('Experiência Profissional'),
          _buildPdfBulletListWithSub(CurriculumData.experiencia),
          pw.SizedBox(height: 15),

          _buildPdfSectionTitle('Cursos e Certificações'),
          _buildPdfBulletList(CurriculumData.cursos),
          pw.SizedBox(height: 15),

          _buildPdfSectionTitle('Habilidades Técnicas'),
          _buildPdfBulletList(CurriculumData.habilidades),
          pw.SizedBox(height: 15),

          _buildPdfSectionTitle('Idiomas'),
          _buildPdfBulletList(CurriculumData.idiomas),
          pw.SizedBox(height: 15),

          _buildPdfSectionTitle('Informações Adicionais'),
          _buildPdfParagraph(CurriculumData.infoAdicional),
        ];
      },
    ),
  );
  return pdf.save();
}

// Funções auxiliares para construir o PDF
pw.Widget _buildPdfHeader() {
  return pw.Container(
    width: double.infinity,
    padding: const pw.EdgeInsets.symmetric(vertical: 20),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Text(
          CurriculumData.nome,
          style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          CurriculumData.titulo,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.normal),
        ),
      ],
    ),
  );
}

pw.Widget _buildPdfSectionTitle(String title) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title.toUpperCase(),
        style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
      ),
      pw.Divider(thickness: 1, color: pw.PdfColors.grey800),
      pw.SizedBox(height: 8),
    ],
  );
}

pw.Widget _buildPdfContactInfo() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: CurriculumData.contato.entries.map((entry) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 2),
        child: pw.RichText(
          text: pw.TextSpan(
            text: '${entry.key}: ',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12),
            children: [
              pw.TextSpan(
                text: entry.value,
                style: const pw.TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

pw.Widget _buildPdfParagraph(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 10),
    child: pw.Text(
      text,
      style: const pw.TextStyle(fontSize: 12, lineSpacing: 2),
    ),
  );
}

pw.Widget _buildPdfBulletList(List<String> items) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: items
        .map(
          (item) => pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '• ',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  item,
                  style: const pw.TextStyle(fontSize: 12, height: 1.5),
                ),
              ),
            ],
          ),
        )
        .toList(),
  );
}

pw.Widget _buildPdfBulletListWithSub(List<Map<String, dynamic>> items) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: items.map((map) {
      final title = map['title'] as String;
      final subitems = List<String>.from(map['subitems'] ?? []);
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 5),
          ...subitems.map(
            (subitem) => pw.Padding(
              padding: const pw.EdgeInsets.only(left: 15, bottom: 5),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('– ', style: const pw.TextStyle(fontSize: 12)),
                  pw.Expanded(
                    child: pw.Text(
                      subitem,
                      style: const pw.TextStyle(fontSize: 12, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList(),
  );
}
