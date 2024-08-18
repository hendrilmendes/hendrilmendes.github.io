import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:folio/screens/contact/contact.dart';
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
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => _onItemTapped(0),
            child: const Text('Home'),
          ),
          ElevatedButton(
            onPressed: () => _onItemTapped(1),
            child: const Text('Projetos'),
          ),
          ElevatedButton(
            onPressed: () => _onItemTapped(2),
            child: const Text('Skills'),
          ),
          ElevatedButton(
            onPressed: () => _onItemTapped(3),
            child: const Text('Contato'),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
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
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Center(
          child: Text(
            '© $currentYear Hendril Mendes. Todos os direitos reservados.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
