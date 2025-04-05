// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:folio/screens/contact/contact.dart';
import 'package:folio/screens/education/education.dart';
import 'package:folio/screens/home/home.dart';
import 'package:folio/screens/projects/projects.dart';
import 'package:folio/screens/skills/skills.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DesktopNavigationContainer extends StatefulWidget {
  const DesktopNavigationContainer({super.key});

  @override
  State<DesktopNavigationContainer> createState() =>
      _DesktopNavigationContainerState();
}

class _DesktopNavigationContainerState
    extends State<DesktopNavigationContainer> {
  int _currentIndex = 0;
  final int _currentYear = DateTime.now().year;

  final List<Widget> _pages = const [
    HomeScreen(),
    EducationScreen(),
    ProjectsScreen(),
    SkillsScreen(),
    ContactScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[900],
    body: Row(
      children: [
        // Barra de navegação lateral
        Container(
          width: 80,
          margin: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _NavItem(
                icon: Icons.home_filled,
                label: 'Home',
                isActive: _currentIndex == 0,
                onTap: () => _onItemTapped(0),
              ),
              const SizedBox(height: 20),
              _NavItem(
                icon: Icons.school,
                label: 'Formação',
                isActive: _currentIndex == 1,
                onTap: () => _onItemTapped(1),
              ),
              const SizedBox(height: 20),
              _NavItem(
                icon: Icons.work,
                label: 'Projetos',
                isActive: _currentIndex == 2,
                onTap: () => _onItemTapped(2),
              ),
              const SizedBox(height: 20),
              _NavItem(
                icon: Icons.star,
                label: 'Skills',
                isActive: _currentIndex == 3,
                onTap: () => _onItemTapped(3),
              ),
              const SizedBox(height: 20),
              _NavItem(
                icon: Icons.contacts,
                label: 'Contato',
                isActive: _currentIndex == 4,
                onTap: () => _onItemTapped(4),
              ),
            ],
          ),
        ),

        // Conteúdo principal
        Expanded(
          child: PageTransitionSwitcher(
            duration: 500.ms,
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: _pages[_currentIndex],
          ),
        ),
      ],
    ),

      // Rodapé
      bottomNavigationBar: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.blueAccent.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '© $_currentYear Hendril Mendes',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                const TextSpan(
                  text: ' - ',
                  style: TextStyle(color: Colors.grey),
                ),
                WidgetSpan(
                  child: Icon(Icons.favorite, color: Colors.red, size: 14),
                ),
                const TextSpan(
                  text: ' Flutter | Todos os direitos reservados.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color:
                isActive
                    ? Colors.blueAccent.withOpacity(0.2)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.blueAccent : Colors.grey[400],
                size: 28,
              ),
              const SizedBox(height: 4),
              if (isActive)
                Text(
                  label,
                  style: TextStyle(color: Colors.blueAccent, fontSize: 10),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
