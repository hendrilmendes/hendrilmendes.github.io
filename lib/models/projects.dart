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
    titulo: 'Tarefas',
    descricao: 'Um app para você salvar suas tarefas e anotações do dia a dia',
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
    titulo: 'Shop',
    descricao: 'Sua Loja',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Shop/main/assets/img/ic_launcher.png',
    urlProject: 'https://github.com/hendrilmendes/Shop',
  ),
  Projeto(
    titulo: 'Shop-Backend',
    descricao: 'Dashboard do app Shop',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Shop-Backend/main/screenshots/preview.png',
    urlProject: 'https://github.com/hendrilmendes/Shop-Backend',
  ),
  Projeto(
    titulo: 'Pulse Messenger',
    descricao: 'Uma rede social criada no flutter',
    imagemUrl:
        'https://raw.githubusercontent.com/hendrilmendes/Pulse-Messenger/main/assets/img/logo.png',
    urlProject: 'https://github.com/hendrilmendes/Pulse-Messenger',
  ),
];
