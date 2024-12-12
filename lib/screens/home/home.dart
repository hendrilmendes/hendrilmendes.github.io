import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _titles = [
    'Técnico em Informática',
    'Dev Mobile',
    'Estudante de Engenharia',
  ];

  int _currentTitleIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTitleRotation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTitleRotation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      setState(() {
        _currentTitleIndex = (_currentTitleIndex + 1) % _titles.length;
      });
    });
  }

  Future<void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchUrlPDF() async {
    final Uri url = Uri.parse(
        'https://1drv.ms/b/s!Ahw1Ik4ugCxajaI09DxcBh5vPl99hg?e=wAOiLK');
    // ignore: deprecated_member_use
    if (await canLaunch(url.toString())) {
      // ignore: deprecated_member_use
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 30,
                  tooltip: "GitHub",
                  icon: const Icon(MdiIcons.github),
                  onPressed: () =>
                      _launchURL('https://github.com/hendrilmendes'),
                ),
                const SizedBox(height: 16),
                IconButton(
                  iconSize: 30,
                  tooltip: "Telegram",
                  icon: const Icon(MdiIcons.telegram),
                  onPressed: () => _launchURL('https://t.me/hendril_mendes'),
                ),
                const SizedBox(height: 16),
                IconButton(
                  iconSize: 30,
                  tooltip: "LinkedIn",
                  icon: const Icon(MdiIcons.linkedin),
                  onPressed: () =>
                      _launchURL('https://linkedin.com/in/hendril-mendes'),
                ),
                const SizedBox(height: 16),
                IconButton(
                  iconSize: 30,
                  tooltip: "Instagram",
                  icon: const Icon(MdiIcons.instagram),
                  onPressed: () =>
                      _launchURL('https://instagram.com/hendril_mendes'),
                ),
                Divider(),
                IconButton(
                  iconSize: 30,
                  tooltip: "Curriculum",
                  icon: const Icon(MdiIcons.fileDocument),
                  onPressed: () => _launchUrlPDF(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  Container(
                    margin: const EdgeInsets.only(bottom: 24.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/28198780?v=4',
                      ),
                    ),
                  ),

                  // Name
                  Text(
                    'Oi, eu sou o Hendril',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Rotating Titles
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.5),
                            end: const Offset(0, 0),
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      _titles[_currentTitleIndex],
                      key: ValueKey<int>(_currentTitleIndex),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bio Section
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[800],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(),
                          offset: const Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sobre Mim',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Nascido em Minaçu-GO, desde criança, fui apaixonado por tecnologia e me encantei com cada detalhe dela. '
                          'Essa paixão surgiu instantaneamente e ao longo dos anos, me dediquei a adquirir as habilidades e conhecimentos necessários para me tornar um profissional altamente qualificado. '
                          'Desde cedo, tenho um amor pela área da tecnologia e estou sempre em busca de aprender e expandir meu conhecimento em todas as direções. '
                          'Cada aprendizado e conquista em minha carreira são valorizados e apreciados.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
