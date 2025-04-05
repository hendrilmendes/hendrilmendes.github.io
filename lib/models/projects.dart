class Projeto {
  final String titulo;
  final String descricao;
  final String imagemUrl;
  final String urlProject;

  Projeto({
    required this.titulo,
    required this.descricao,
    required this.imagemUrl,
    required this.urlProject,
  });
}

final List<Projeto> projetos = [
  Projeto(
    titulo: 'News-Droid',
    descricao: 'Um projeto amador para um app de notícias',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/News-Droid/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/News-Droid',
  ),
  Projeto(
    titulo: 'Tá na Lista',
    descricao: 'Organize suas tarefas e anotações diárias',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Tarefas/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/Tarefas',
  ),
  Projeto(
    titulo: 'Calculadora',
    descricao: 'Uma calculadora simples escrita em Flutter',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Calculadora/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/Calculadora',
  ),
  Projeto(
    titulo: 'Wally',
    descricao: 'Um assistente virtual',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Wally/main/assets/img/robot_photo.png',
    urlProject: 'https://github.com/hendrilmendes/Wally',
  ),
  Projeto(
    titulo: 'ShopTem',
    descricao: 'Sua Loja',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Shop/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/Shop',
  ),
  Projeto(
    titulo: 'Dashboard ShopTem',
    descricao: 'Dashboard do app ShopTem',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Shop-Dashboard/main/screenshots/preview.png',
    urlProject: 'https://github.com/hendrilmendes/Shop-Dashboard',
  ),
  Projeto(
    titulo: 'Pulse Messenger',
    descricao: 'Conecte-se com o ritmo do mundo',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Pulse-Messenger/main/assets/img/logo.png',
    urlProject: 'https://github.com/hendrilmendes/Pulse-Messenger',
  ),
];
