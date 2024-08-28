import 'package:flutter/material.dart';

class Habilidade {
  final String nome;
  final double nivel; // O nível vai de 0.0 a 1.0
  final String descricao;
  final IconData icone;

  Habilidade({
    required this.nome,
    required this.nivel,
    required this.descricao,
    required this.icone,
  });
}

final List<Habilidade> habilidades = [
  Habilidade(
    nome: 'Flutter',
    nivel: 0.50,
    descricao:
        'Flutter é um framework de UI da Google para construir aplicativos nativos de alta performance '
        'para mobile, web e desktop a partir de uma única base de código.',
    icone: Icons.phone_android,
  ),
  Habilidade(
      nome: 'Dart',
      nivel: 0.50,
      descricao:
          'Dart é uma linguagem de programação otimizada para desenvolvimento de aplicativos móveis, desktop e web, '
          'com suporte a uma sintaxe moderna e uma execução rápida.',
      icone: Icons.code),
  Habilidade(
      nome: 'JavaScript',
      nivel: 0.60,
      descricao:
          'JavaScript é uma linguagem de programação essencial para o desenvolvimento web, '
          'permitindo a criação de interatividade e dinamismo em páginas e aplicativos.',
      icone: Icons.web),
  Habilidade(
      nome: 'HTML',
      nivel: 0.85,
      descricao:
          'HTML é uma linguagem de marcação usada para estruturar e criar o conteúdo de páginas web.',
      icone: Icons.language),
  Habilidade(
      nome: 'CSS',
      nivel: 0.85,
      descricao:
          'CSS é uma linguagem de estilo usada para definir a aparência e o layout de páginas web.',
      icone: Icons.palette),
  Habilidade(
      nome: 'Python',
      nivel: 0.60,
      descricao:
          'Python é uma linguagem de programação de alto nível conhecida por sua sintaxe simples e legibilidade,'
          'amplamente usada para desenvolvimento web, análise de dados e automação.',
      icone: Icons.memory),
];
