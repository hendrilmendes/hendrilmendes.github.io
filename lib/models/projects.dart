class Projeto {
  final String titulo;
  final String descricao;
  final String imagemUrl;
  final String urlProject;
  final String categoria;
  final List<String> tags;
  final bool destaque;

  Projeto({
    required this.titulo,
    required this.descricao,
    required this.imagemUrl,
    required this.urlProject,
    required this.categoria,
    required this.tags,
    this.destaque = false,
  });
}

final List<Projeto> projetos = [
  Projeto(
    titulo: 'Pulse Messenger',
    descricao:
        'Um app de mensagens em tempo real com Flutter e Firebase, focando em performance e UI limpa.',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Pulse-Messenger/main/assets/img/logo.png',
    urlProject: 'https://github.com/hendrilmendes/Pulse-Messenger',
    categoria: 'Redes Sociais',
    tags: ['Flutter', 'Firebase', 'Realtime Chat', 'UI/UX'],
    destaque: true,
  ),
  Projeto(
    titulo: 'Dashboard ShopTem',
    descricao:
        'Painel administrativo para a plataforma de e-commerce ShopTem, construído com Flutter Web.',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Shop-Dashboard/main/screenshots/preview.png',
    urlProject: 'https://github.com/hendrilmendes/Shop-Dashboard',
    categoria: 'Dashboards',
    tags: ['Flutter Web', 'Admin', 'Analytics', 'Charts'],
    destaque: true,
  ),
  Projeto(
    titulo: 'News-Droid',
    descricao:
        'Aplicativo agregador de notícias que consome a API do Blogger para exibir posts de forma nativa.',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/News-Droid/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/News-Droid',
    categoria: 'Aplicativos',
    tags: ['Flutter', 'Blogger API', 'Notícias'],
    destaque: false,
  ),
  Projeto(
    titulo: 'Tá na Lista',
    descricao:
        'Organize suas tarefas e anotações diárias com este app simples e funcional integrado ao Firebase.',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Tarefas/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/Tarefas',
    categoria: 'Ferramentas',
    tags: ['Flutter', 'Firebase', 'Produtividade'],
    destaque: false,
  ),
  Projeto(
    titulo: 'ShopTem',
    descricao:
        'Aplicativo de e-commerce completo com carrinho, checkout e integração com backend Dart.',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Shop/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/Shop',
    categoria: 'Aplicativos',
    tags: ['Flutter', 'E-commerce', 'Firebase'],
    destaque: false,
  ),
  Projeto(
    titulo: 'Calculadora',
    descricao:
        'Uma calculadora com design moderno e funcionalidades básicas, ótima para praticar a lógica de UI.',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Calculadora/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/Calculadora',
    categoria: 'Ferramentas',
    tags: ['Flutter', 'Dart', 'UI'],
    destaque: false,
  ),
  Projeto(
    titulo: 'Wally',
    descricao:
        'Um protótipo de assistente virtual para explorar interações de voz e processamento de linguagem.',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Wally/main/assets/img/robot_photo.png',
    urlProject: 'https://github.com/hendrilmendes/Wally',
    categoria: 'Aplicativos', // Pode ser 'Ferramentas' também
    tags: ['Flutter', 'IA', 'Assistente Virtual'],
    destaque: false,
  ),
];
