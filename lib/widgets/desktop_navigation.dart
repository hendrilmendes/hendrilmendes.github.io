import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:folio/screens/contact/contact.dart';
import 'package:folio/screens/education/education.dart';
import 'package:folio/screens/home/home.dart';
import 'package:folio/screens/projects/projects.dart';
import 'package:folio/screens/skills/skills.dart';

class DesktopNavigationContainer extends StatefulWidget {
  const DesktopNavigationContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DesktopNavigationContainerState createState() =>
      _DesktopNavigationContainerState();
}

class _DesktopNavigationContainerState
    extends State<DesktopNavigationContainer> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    EducationScreen(),
    ProjectsScreen(),
    SkillsScreen(),
    ContactScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;

    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton.tonal(
                    onPressed: () => _onItemTapped(0),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentIndex == 0 ? Colors.blue : null,
                    ),
                    child: const Text('Home'),
                  ),
                  SizedBox(width: 10),
                  FilledButton.tonal(
                    onPressed: () => _onItemTapped(1),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentIndex == 1 ? Colors.blue : null,
                    ),
                    child: const Text('Formação'),
                  ),
                  SizedBox(width: 10),
                  FilledButton.tonal(
                    onPressed: () => _onItemTapped(2),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentIndex == 2 ? Colors.blue : null,
                    ),
                    child: const Text('Projetos'),
                  ),
                  SizedBox(width: 10),
                  FilledButton.tonal(
                    onPressed: () => _onItemTapped(3),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentIndex == 3 ? Colors.blue : null,
                    ),
                    child: const Text('Skills'),
                  ),
                  SizedBox(width: 10),
                  FilledButton.tonal(
                    onPressed: () => _onItemTapped(4),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentIndex == 4 ? Colors.blue : null,
                    ),
                    child: const Text('Contato'),
                  ),
                ],
              ),
            ),
          ),
          // Exibindo a tela selecionada
          Expanded(
            child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: _pages[_currentIndex],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 40,
        child: Center(
          child: Text(
            '© $currentYear Hendril Mendes - ❤️ Flutter | Todos os direitos reservados.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
