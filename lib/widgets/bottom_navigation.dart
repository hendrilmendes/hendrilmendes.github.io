// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folio/screens/contact/contact.dart';
import 'package:folio/screens/education/education.dart';
import 'package:folio/screens/home/home.dart';
import 'package:folio/screens/projects/projects.dart';
import 'package:folio/screens/skills/skills.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavigationContainer extends StatefulWidget {
  const BottomNavigationContainer({super.key});

  @override
  State<BottomNavigationContainer> createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = const [
    HomeScreen(),
    EducationScreen(),
    ProjectsScreen(),
    SkillsScreen(),
    ContactScreen(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': MdiIcons.homeVariant, 'label': 'Home'},
    {'icon': MdiIcons.school, 'label': 'Formação'},
    {'icon': MdiIcons.folderStar, 'label': 'Projetos'},
    {'icon': MdiIcons.starCircle, 'label': 'Skills'},
    {'icon': MdiIcons.email, 'label': 'Contato'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    if (_currentIndex == index) return;

    HapticFeedback.lightImpact();

    setState(() => _currentIndex = index);

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a192f),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _screens,
          ),

          _buildFloatingNavBar(),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final navBarWidth = min(screenWidth * 0.9, 500.0);
    final itemWidth = navBarWidth / _navItems.length;

    return Positioned(
      bottom: 20,
      left: (screenWidth - navBarWidth) / 2,
      right: (screenWidth - navBarWidth) / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  left: itemWidth * _currentIndex,
                  width: itemWidth,
                  height: 65,
                  child: Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_navItems.length, (index) {
                    final item = _navItems[index];
                    return _NavItem(
                      icon: item['icon'],
                      label: item['label'],
                      isSelected: _currentIndex == index,
                      onTap: () => _onTabTapped(index),
                    );
                  }),
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
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[400],
              size: 24,
            ),
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: isSelected ? 16 : 0,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
