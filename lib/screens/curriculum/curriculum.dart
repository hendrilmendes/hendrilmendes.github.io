import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pdf/pdf.dart' as pw;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// Tela que exibe o currículo
class CurriculumScreen extends StatelessWidget {
  const CurriculumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text('Currículo'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          const CurriculumOptionButton(),
          SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Hendril Mendes Ribeiro',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Técnico em Informática',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Seção de Contato
                const SectionTitle(title: 'Contato'),
                const SizedBox(height: 10),
                const ContactInfo(),
                const SizedBox(height: 25),
                // Objetivo Profissional
                const SectionTitle(title: 'Objetivo Profissional'),
                const SizedBox(height: 10),
                const Text(
                  'Atuar na área de Tecnologia da Informação, contribuindo com minhas habilidades em manutenção de sistemas, suporte técnico, administração de redes e desenvolvimento de soluções (web e mobile), agregando valor à equipe e à empresa.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                // Formação Acadêmica
                const SectionTitle(title: 'Formação Acadêmica'),
                const SizedBox(height: 10),
                const BulletList(
                  items: [
                    'Engenharia da Computação: Universidade Cruzeiro do Sul, Jauru-MT (Em andamento)',
                  ],
                ),
                const SizedBox(height: 25),
                // Experiência Profissional
                const SectionTitle(title: 'Experiência Profissional'),
                const SizedBox(height: 10),
                const BulletListWithSub(
                  items: [
                    {
                      'title':
                          'Técnico em Informática – NetSYS Internet & Informática (2018 – Atual)',
                      'subitems': [
                        'Análise e otimização de sistemas, realizando diagnóstico e reparo de hardware e software para maximizar a performance e a confiabilidade.\n',
                        'Infraestrutura de redes, incluindo implantação, configuração e manutenção para ambientes empresariais, garantindo segurança e alta disponibilidade.\n',
                        'Suporte técnico especializado, oferecendo atendimento ágil e soluções eficazes para clientes, assegurando a continuidade e eficiência operacional',
                      ],
                    },
                  ],
                ),
                const SizedBox(height: 25),
                // Cursos e Certificações
                const SectionTitle(title: 'Cursos e Certificações'),
                const SizedBox(height: 10),
                const BulletList(
                  items: [
                    'Startto.dev (2023) - Criação de apps utilizando Flutter.',
                    'SENAI (2022) - Tecnologia da Informação e Comunicação.',
                    'Microsoft (2022) - HTML, CSS, JavaScript.',
                    'Didática Tech (2022) - Python.',
                    'NetSYS Internet & Informática (2017) - Windows 7 e Windows 8, Microsoft Office, CorelDraw X7, Photoshop CC.',
                    'Brasil Treinamentos (2015) - Manutenção e Reparação de Microcomputadores e Redes.',
                  ],
                ),
                const SizedBox(height: 25),
                // Habilidades Técnicas
                const SectionTitle(title: 'Habilidades Técnicas'),
                const SizedBox(height: 10),
                const BulletList(
                  items: [
                    'Suporte Técnico e Atendimento: Atendimento ao cliente e resolução de problemas técnicos.',
                    'Manutenção de Hardware: Reparação e manutenção de microcomputadores.',
                    'Administração de Redes: Configuração e gerenciamento de redes e servidores.',
                    'Desenvolvimento: HTML, CSS, JavaScript, Python e desenvolvimento de apps com Flutter/Dart.',
                    'Ferramentas: Microsoft Office, VMWare, CorelDraw, Photoshop; familiaridade com Windows, macOS e Linux.',
                  ],
                ),
                const SizedBox(height: 25),
                // Idiomas
                const SectionTitle(title: 'Idiomas'),
                const SizedBox(height: 10),
                const BulletList(
                  items: ['Inglês: Intermediário', 'Espanhol: Intermediário'],
                ),
                const SizedBox(height: 25),
                // Informações Adicionais
                const SectionTitle(title: 'Informações Adicionais'),
                const SizedBox(height: 10),
                const Text(
                  'Tenho 24 anos e busco constante evolução pessoal e profissional, com facilidade de aprendizado e adaptação a novas tecnologias.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Botão com as opções de salvar como PDF ou imprimir
class CurriculumOptionButton extends StatelessWidget {
  const CurriculumOptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 30,
      tooltip: "Curriculum",
      icon: const Icon(MdiIcons.fileDocument),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.picture_as_pdf),
                    title: const Text("Salvar como PDF"),
                    onTap: () async {
                      final pdfBytes = await _generatePdf(pw.PdfPageFormat.a4);
                      await Printing.sharePdf(
                        bytes: pdfBytes,
                        filename: 'curriculum.pdf',
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.print),
                    title: const Text("Imprimir"),
                    onTap: () async {
                      await Printing.layoutPdf(
                        onLayout: (format) => _generatePdf(format),
                      );
                      // ignore: use_build_context_synchronously
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

// Função que gera o PDF com o conteúdo do currículo
Future<Uint8List> _generatePdf(pw.PdfPageFormat format) async {
  final pdf = pw.Document();
  final primaryColor = pw.PdfColor.fromHex('2C3E50');

  pdf.addPage(
    pw.MultiPage(
      pageFormat: format,
      theme: pw.ThemeData.withFont(
        base: await PdfGoogleFonts.openSansRegular(),
        bold: await PdfGoogleFonts.openSansBold(),
      ),
      build: (pw.Context context) {
        return [
          _buildHeader(primaryColor),
          pw.SizedBox(height: 20),
          _buildSectionTitle('Contato'),
          pw.SizedBox(height: 8),
          _buildContactInfo(),
          _buildSectionTitle('Objetivo Profissional'),
          pw.SizedBox(height: 8),
          _buildParagraph(
            'Atuar na área de Tecnologia da Informação, contribuindo com minhas habilidades em manutenção de sistemas, suporte técnico, administração de redes e desenvolvimento de soluções (web e mobile), agregando valor à equipe e à empresa.',
          ),
          _buildSectionTitle('Formação Acadêmica'),
          pw.SizedBox(height: 8),
          _buildBulletList([
            'Engenharia da Computação: Universidade Cruzeiro do Sul, Jauru-MT (Em andamento)',
          ]),
          _buildSectionTitle('Experiência Profissional'),
          pw.SizedBox(height: 8),
          _buildBulletListWithSub({
            'Técnico em Informática – NetSYS Internet & Informática (2018 – Atual)': [
              'Análise e otimização de sistemas, realizando diagnóstico e reparo de hardware e software para maximizar a performance e a confiabilidade.\n',
              'Infraestrutura de redes, incluindo implantação, configuração e manutenção para ambientes empresariais, garantindo segurança e alta disponibilidade.\n',
              'Suporte técnico especializado, oferecendo atendimento ágil e soluções eficazes para clientes, assegurando a continuidade e eficiência operacional\n',
            ],
          }),
          _buildSectionTitle('Cursos e Certificações'),
          pw.SizedBox(height: 8),
          _buildBulletList([
            'Startto.dev (2023) - Criação de apps utilizando Flutter.',
            'SENAI (2022) - Tecnologia da Informação e Comunicação.',
            'Microsoft (2022) - HTML, CSS, JavaScript.',
            'Didática Tech (2022) - Python.',
            'NetSYS Internet & Informática (2017) - Windows 7 e Windows 8, Microsoft Office, CorelDraw X7, Photoshop CC.',
            'Brasil Treinamentos (2015) - Manutenção e Reparação de Microcomputadores e Redes.',
          ]),
          _buildSectionTitle('Habilidades Técnicas'),
          pw.SizedBox(height: 8),
          _buildBulletList([
            'Suporte Técnico e Atendimento: Atendimento ao cliente e resolução de problemas técnicos.',
            'Manutenção de Hardware: Reparação e manutenção de microcomputadores.',
            'Administração de Redes: Configuração e gerenciamento de redes e servidores.',
            'Desenvolvimento: HTML, CSS, JavaScript, Python e desenvolvimento de apps com Flutter/Dart.',
            'Ferramentas: Microsoft Office, VMWare, CorelDraw, Photoshop; familiaridade com Windows, macOS e Linux.',
          ]),
          _buildSectionTitle('Idiomas'),
          pw.SizedBox(height: 8),
          _buildBulletList([
            'Inglês: Intermediário',
            'Espanhol: Intermediário',
          ]),
          _buildSectionTitle('Informações Adicionais'),
          pw.SizedBox(height: 8),
          _buildParagraph(
            'Tenho 24 anos e busco constante evolução pessoal e profissional, com facilidade de aprendizado e adaptação a novas tecnologias.',
          ),
        ];
      },
    ),
  );
  return pdf.save();
}

pw.Widget _buildHeader(pw.PdfColor color) {
  return pw.Container(
    width: double.infinity,
    color: color,
    padding: const pw.EdgeInsets.symmetric(vertical: 20),
    child: pw.Column(
      children: [
        pw.Text(
          'Hendril Mendes Ribeiro',
          style: pw.TextStyle(
            fontSize: 28,
            color: pw.PdfColors.white,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          'Técnico em Informática',
          style: pw.TextStyle(
            fontSize: 16,
            color: pw.PdfColors.white,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildSectionTitle(String title) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 18,
          fontWeight: pw.FontWeight.bold,
          decoration: pw.TextDecoration.underline,
          color: pw.PdfColor.fromHex('2C3E50'),
        ),
      ),
      pw.SizedBox(height: 5),
    ],
  );
}

pw.Widget _buildContactInfo() {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _buildContactItem('E-mail:', 'hendrilmendes2015@gmail.com'),
      _buildContactItem('Telefone:', '+55 65 99361-1847'),
      _buildContactItem('Local:', 'Jauru, MT, Brasil'),
      _buildContactItem('Portfólio:', 'hendrilmendes.github.io'),
      _buildContactItem('LinkedIn:', 'linkedin.com/in/hendril-mendes'),
      pw.SizedBox(height: 15),
    ],
  );
}

pw.Widget _buildContactItem(String label, String value) {
  return pw.RichText(
    text: pw.TextSpan(
      text: '$label ',
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 14,
        color: pw.PdfColor.fromHex('2C3E50'),
      ),
      children: [
        pw.TextSpan(
          text: value,
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.normal,
            color: pw.PdfColors.black,
          ),
        ),
      ],
    ),
  );
}

pw.Widget _buildParagraph(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 20),
    child: pw.Text(
      text,
      style: const pw.TextStyle(fontSize: 14, lineSpacing: 2),
    ),
  );
}

pw.Widget _buildBulletList(List<String> items) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      for (var item in items)
        pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('• ', style: const pw.TextStyle(fontSize: 14)),
              pw.Expanded(
                child: pw.Text(
                  item,
                  style: const pw.TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      pw.SizedBox(height: 15),
    ],
  );
}

pw.Widget _buildBulletListWithSub(Map<String, List<String>> items) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      for (var entry in items.entries)
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              entry.key,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 5),
            ...entry.value.map(
              (subItem) => pw.Padding(
                padding: const pw.EdgeInsets.only(left: 15, bottom: 5),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('– ', style: const pw.TextStyle(fontSize: 14)),
                    pw.Expanded(
                      child: pw.Text(
                        subItem,
                        style: const pw.TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 10),
          ],
        ),
      pw.SizedBox(height: 15),
    ],
  );
}

// Widget para títulos das seções
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white,
      ),
    );
  }
}

// Widget para listas com marcadores simples
class BulletList extends StatelessWidget {
  final List<String> items;
  const BulletList({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "• ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}

// Widget para listas com subtítulos
class BulletListWithSub extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const BulletListWithSub({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((map) {
            final title = map['title'] as String;
            final List<String> subitems = List<String>.from(
              map['subitems'] ?? [],
            );
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
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          subitems.map((subitem) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "– ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      subitem,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}

// Widget para exibir informações de contato
class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ContactItem(label: 'E-mail', value: 'hendrilmendes2015@gmail.com'),
        ContactItem(label: 'Telefone', value: '+55 65 99361-1847'),
        ContactItem(label: 'Local', value: 'Jauru, MT, Brasil'),
        ContactItem(label: 'Portfólio', value: 'hendrilmendes.github.io'),
        ContactItem(label: 'LinkedIn', value: 'linkedin.com/in/hendril-mendes'),
      ],
    );
  }
}

// Widget para cada item de contato
class ContactItem extends StatelessWidget {
  final String label;
  final String value;
  const ContactItem({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
