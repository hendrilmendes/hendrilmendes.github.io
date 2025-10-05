class Education {
  final String title;
  final String institution;
  final String year;
  final String type;

  Education({
    required this.title,
    required this.institution,
    required this.year,
    required this.type,
  });
}

final List<Education> educationData = [
  Education(
    title: 'Engenharia de Computação',
    institution: 'Universidade Cruzeiro do Sul, Jauru-MT',
    year: '2027',
    type: 'graduação',
  ),
  Education(
    title: 'Criação de apps com Flutter',
    institution: 'Startto.dev',
    year: '2023',
    type: 'curso',
  ),
  Education(
    title: 'Python',
    institution: 'Didática Tech',
    year: '2022',
    type: 'curso',
  ),
  Education(
    title: 'HTML, CSS, JavaScript',
    institution: 'Microsoft',
    year: '2022',
    type: 'curso',
  ),
  Education(
    title: 'Tecnologia da Informação e Comunicação',
    institution: 'SENAI',
    year: '2022',
    type: 'curso',
  ),
  Education(
    title: 'Windows 7 e Windows 8',
    institution: 'NetSYS Internet & Informática',
    year: '2017',
    type: 'curso',
  ),
  Education(
    title: 'Microsoft Office',
    institution: 'NetSYS Internet & Informática',
    year: '2017',
    type: 'curso',
  ),
  Education(
    title: 'CorelDraw X7',
    institution: 'NetSYS Internet & Informática',
    year: '2017',
    type: 'curso',
  ),
  Education(
    title: 'Photoshop CC',
    institution: 'NetSYS Internet & Informática',
    year: '2017',
    type: 'curso',
  ),
  Education(
    title: 'Manutenção e Reparação de Microcomputadores e Redes',
    institution: 'Brasil Treinamentos',
    year: '2015',
    type: 'curso',
  ),
];
