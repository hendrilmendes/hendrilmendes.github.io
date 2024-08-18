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
      descricao: 'Desenvolvimento mobile e web com Flutter.',
      icone: Icons.phone_android),
  Habilidade(
      nome: 'Dart',
      nivel: 0.50,
      descricao: 'Linguagem de programação usada com Flutter.',
      icone: Icons.code),
  Habilidade(
      nome: 'JavaScript',
      nivel: 0.60,
      descricao: 'Linguagem de programação para desenvolvimento web.',
      icone: Icons.web),
  Habilidade(
      nome: 'HTML',
      nivel: 0.85,
      descricao: 'Linguagem de marcação para criar estruturas de páginas web.',
      icone: Icons.language),
  Habilidade(
      nome: 'CSS',
      nivel: 0.85,
      descricao:
          'Linguagem de estilo para definir a aparência das páginas web.',
      icone: Icons.palette),
  Habilidade(
      nome: 'Python',
      nivel: 0.60,
      descricao:
          'Linguagem de programação versátil usada em diversos tipos de aplicações.',
      icone: Icons.memory),
];
