import 'package:flutter/material.dart';

class Habilidade {
  final String nome;
  final double nivel;
  final String descricao;
  final IconData icone;
  final String categoria;
  final bool destaque;
  final List<String> tags;

  Habilidade({
    required this.nome,
    required this.nivel,
    required this.descricao,
    required this.icone,
    required this.categoria,
    this.destaque = false,
    required this.tags,
  });
}

final List<Habilidade> habilidades = [
  Habilidade(
    nome: 'Flutter',
    nivel: 0.50,
    descricao:
        'Desenvolvimento de apps multiplataforma com widgets customizáveis e alto desempenho.',
    icone: Icons.phone_android,
    categoria: 'Frameworks',
    destaque: true,
    tags: ['Cross-platform', 'UI'],
  ),
  Habilidade(
    nome: 'Dart',
    nivel: 0.50,
    descricao:
        'Linguagem otimizada para UI, com compilação nativa e forte tipagem.',
    icone: Icons.code,
    categoria: 'Linguagens',
    destaque: true,
    tags: ['OOP', 'Null Safety', 'Async/Await'],
  ),
  Habilidade(
    nome: 'JavaScript',
    nivel: 0.50,
    descricao:
        'Desenvolvimento web interativo com manipulação de DOM e APIs modernas.',
    icone: Icons.web,
    categoria: 'Linguagens',
    destaque: false,
    tags: ['ES6+', 'Node.js', 'APIs'],
  ),
  Habilidade(
    nome: 'HTML5',
    nivel: 0.70,
    descricao: 'Estruturação semântica de conteúdo web com APIs modernas.',
    icone: Icons.language,
    categoria: 'Web',
    destaque: false,
    tags: ['Semântica', 'Acessibilidade', 'SEO'],
  ),
  Habilidade(
    nome: 'CSS3',
    nivel: 0.70,
    descricao: 'Estilização avançada com Flexbox, Grid, animações e variáveis.',
    icone: Icons.palette,
    categoria: 'Web',
    destaque: false,
    tags: ['Responsivo', 'Animações'],
  ),
  Habilidade(
    nome: 'Python',
    nivel: 0.40,
    descricao: 'Automação, análise de dados e scripts com sintaxe limpa.',
    icone: Icons.memory,
    categoria: 'Linguagens',
    destaque: false,
    tags: ['Pandas', 'Automation', 'Scripting'],
  ),
  Habilidade(
    nome: 'Git',
    nivel: 0.60,
    descricao: 'Controle de versão distribuído para projetos colaborativos.',
    icone: Icons.code,
    categoria: 'Ferramentas',
    destaque: false,
    tags: ['GitHub', 'GitFlow', 'CI/CD'],
  ),
  Habilidade(
    nome: 'Firebase',
    nivel: 0.50,
    descricao:
        'Backend como serviço com banco de dados em tempo real e autenticação.',
    icone: Icons.cloud,
    categoria: 'Backend',
    destaque: true,
    tags: ['Firestore', 'Auth', 'Hosting'],
  ),
  Habilidade(
    nome: 'UI/UX Design',
    nivel: 0.50,
    descricao:
        'Criação de interfaces intuitivas com foco na experiência do usuário.',
    icone: Icons.design_services,
    categoria: 'Design',
    destaque: true,
    tags: ['Figma', 'Prototipagem', 'Wireframes'],
  ),
  Habilidade(
    nome: 'Responsive Design',
    nivel: 0.50,
    descricao: 'Adaptação de layouts para diferentes tamanhos de tela.',
    icone: Icons.screen_rotation,
    categoria: 'Web',
    destaque: true,
    tags: ['Media Queries', 'Mobile First', 'Viewport'],
  ),
];
