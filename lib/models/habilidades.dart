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
        'Framework da Google para criar apps nativos de alta performance em várias plataformas.',
    icone: Icons.phone_android,
  ),
  Habilidade(
    nome: 'Dart',
    nivel: 0.50,
    descricao:
        'Linguagem de programação para apps móveis, desktop e web, com execução rápida.',
    icone: Icons.code,
  ),
  Habilidade(
    nome: 'JavaScript',
    nivel: 0.10,
    descricao:
        'Linguagem essencial para desenvolvimento web, criando interatividade em páginas e apps.',
    icone: Icons.web,
  ),
  Habilidade(
    nome: 'HTML',
    nivel: 0.50,
    descricao:
        'Linguagem de marcação para estruturar o conteúdo de páginas web.',
    icone: Icons.language,
  ),
  Habilidade(
    nome: 'CSS',
    nivel: 0.50,
    descricao:
        'Linguagem de estilo para definir a aparência e layout de páginas web.',
    icone: Icons.palette,
  ),
  Habilidade(
    nome: 'Python',
    nivel: 0.10,
    descricao:
        'Linguagem de programação conhecida por sua simplicidade, usada em web, dados e automação.',
    icone: Icons.memory,
  ),
];
