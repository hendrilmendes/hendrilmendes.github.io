// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:folio/screens/contact/contact.dart';
import 'package:folio/screens/education/education.dart';
import 'package:folio/screens/home/home.dart';
import 'package:folio/screens/projects/projects.dart';
import 'package:folio/screens/skills/skills.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BottomNavigationContainer extends StatefulWidget {
  const BottomNavigationContainer({super.key});

  @override
  State<BottomNavigationContainer> createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer> {
  int _currentIndex = 0;
  bool _extendedNavigation = true;

  final List<Widget> _screens = const [
    HomeScreen(),
    EducationScreen(),
    ProjectsScreen(),
    SkillsScreen(),
    ContactScreen(),
  ];

  void _onTabTapped(int index) {
    if (_currentIndex == index) {
      setState(() => _extendedNavigation = !_extendedNavigation);
      return;
    }

    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: PageTransitionSwitcher(
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
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: AnimatedContainer(
            duration: 300.ms,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.grey[850]!, Colors.grey[900]!],
              ),
              border: Border(
                top: BorderSide(
                  color: Colors.blueAccent.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  opacity: _extendedNavigation ? 1.0 : 0.0,
                  duration: 300.ms,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                  ),
                ),
                NavigationBar(
                  onDestinationSelected: _onTabTapped,
                  selectedIndex: _currentIndex,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  destinations: [
                    _NavigationDestination(
                      icon: Icons.home_filled,
                      label: "Home",
                      isActive: _currentIndex == 0,
                    ),
                    _NavigationDestination(
                      icon: Icons.school,
                      label: "Formação",
                      isActive: _currentIndex == 1,
                    ),
                    _NavigationDestination(
                      icon: Icons.work,
                      label: "Projetos",
                      isActive: _currentIndex == 2,
                    ),
                    _NavigationDestination(
                      icon: Icons.star,
                      label: "Skills",
                      isActive: _currentIndex == 3,
                    ),
                    _NavigationDestination(
                      icon: Icons.contacts,
                      label: "Contato",
                      isActive: _currentIndex == 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationDestination extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavigationDestination({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: isActive ? Colors.blueAccent : Colors.grey[400],
        ),
      ),
      label: label,
      selectedIcon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueAccent.withOpacity(0.3),
        ),
        child: Icon(icon, color: Colors.blueAccent),
      ),
    );
  }
}
