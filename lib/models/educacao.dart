class Education {
  final String title;
  final String institution;
  final String year;
  final String? certificateUrl;

  Education({
    required this.title,
    required this.institution,
    required this.year,
    this.certificateUrl,
  });
}

final List<Education> educationData = [
  Education(
    title: 'Engenharia da Computação',
    institution: 'Universidade Cruzeiro do Sul, Jauru-MT',
    year: 'Conclusão: 2027 (previsto)',
  ),
  Education(
    title: 'Criação de apps com Flutter',
    institution: 'Startto.dev',
    year: '2023',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFpgjQMAAAABFEPQTFExq_ag-xzNH02Eqw?e=8YxnVl',
  ),
  Education(
    title: 'Python',
    institution: 'Didática Tech',
    year: '2022',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFo0eAEAAAABVMcfqk81helNxOWdjqoH-A?e=jmhwLs',
  ),
  Education(
    title: 'HTML, CSS, JavaScript',
    institution: 'Microsoft',
    year: '2022',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFqLawEAAAABEtoBwh-xFp31xjPQdoozVA?e=vEGDTd',
  ),
  Education(
    title: 'Tecnologia da Informação e Comunicação',
    institution: 'SENAI',
    year: '2022',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFrydAEAAAABAm7gqQqUkwWXUDQr2T7kHQ?e=XfmUpG',
  ),
  Education(
    title: 'Windows 7 e Windows 8',
    institution: 'NetSYS Internet & Informática',
    year: '2017',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFrTrAEAAAAB1FPShsDh89Dos-PT0rwWdQ?e=USCI9g',
  ),
  Education(
    title: 'Microsoft Office',
    institution: 'NetSYS Internet & Informática',
    year: '2017',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFrTrAEAAAAB1FPShsDh89Dos-PT0rwWdQ?e=USCI9g',
  ),
  Education(
    title: 'CorelDraw X7',
    institution: 'NetSYS Internet & Informática',
    year: '2017',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFrTrAEAAAAB1FPShsDh89Dos-PT0rwWdQ?e=USCI9g',
  ),
  Education(
    title: 'Photoshop CC',
    institution: 'NetSYS Internet & Informática',
    year: '2017',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFrTrAEAAAAB1FPShsDh89Dos-PT0rwWdQ?e=USCI9g',
  ),
  Education(
    title: 'Manutenção e Reparação de Microcomputadores e Redes',
    institution: 'Brasil Treinamentos',
    year: '2015',
    certificateUrl:
        'https://1drv.ms/b/c/5a2c802e4e22351c/ERw1Ik4ugCwggFrSrAEAAAABowEAHCZEmt3biIhivBSOFQ?e=mQ7gHA',
  ),
];
