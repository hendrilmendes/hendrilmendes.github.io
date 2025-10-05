// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folio/configs/app_theme.dart';
import 'package:folio/screens/contact/contact.dart';
import 'package:folio/screens/education/education.dart';
import 'package:folio/screens/home/home.dart';
import 'package:folio/screens/projects/projects.dart';
import 'package:folio/screens/skills/skills.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavItem {
  final IconData icon;
  final String label;
  final Widget screen;

  const BottomNavItem({
    required this.icon,
    required this.label,
    required this.screen,
  });
}

class BottomNavigationContainer extends StatefulWidget {
  const BottomNavigationContainer({super.key});

  @override
  State<BottomNavigationContainer> createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late final List<GlobalKey> _navItemKeys;
  Offset _indicatorPosition = Offset.zero;
  Size _indicatorSize = Size.zero;
  bool _isIndicatorReady = false;

  final List<BottomNavItem> _navigationItems = const [
    BottomNavItem(
      icon: MdiIcons.homeVariant,
      label: 'Home',
      screen: HomeScreen(),
    ),
    BottomNavItem(
      icon: MdiIcons.school,
      label: 'Formação',
      screen: EducationScreen(),
    ),
    BottomNavItem(
      icon: MdiIcons.folderStar,
      label: 'Projetos',
      screen: ProjectsScreen(),
    ),
    BottomNavItem(
      icon: MdiIcons.starCircle,
      label: 'Skills',
      screen: SkillsScreen(),
    ),
    BottomNavItem(
      icon: MdiIcons.email,
      label: 'Contato',
      screen: ContactScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _navItemKeys = List.generate(_navigationItems.length, (_) => GlobalKey());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _updateIndicatorPosition(0, isInitial: true);
    });
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;
    HapticFeedback.lightImpact();
    setState(() => _currentIndex = index);
    _updateIndicatorPosition(index);

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void _updateIndicatorPosition(int index, {bool isInitial = false}) {
    if (!mounted || _navItemKeys[index].currentContext == null) return;

    final RenderBox navBarBox = context.findRenderObject() as RenderBox;
    final RenderBox navItemBox =
        _navItemKeys[index].currentContext!.findRenderObject() as RenderBox;

    final itemOffset = navBarBox.globalToLocal(
      navItemBox.localToGlobal(Offset.zero),
    );

    setState(() {
      _indicatorPosition = itemOffset;
      _indicatorSize = navItemBox.size;
      if (isInitial) _isIndicatorReady = true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cBackground,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            physics: const NeverScrollableScrollPhysics(),
            children: _navigationItems.map((item) => item.screen).toList(),
          ),
          _buildFloatingBottomBar(),
        ],
      ),
    );
  }

  Widget _buildFloatingBottomBar() {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 20;
    return Positioned(
      bottom: bottomPadding,
      left: 20,
      right: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 12),
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
              alignment: Alignment.center,
              children: [
                _buildSpotlightIndicator(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    _navigationItems.length,
                    (index) => _NavItem(
                      key: _navItemKeys[index],
                      icon: _navigationItems[index].icon,
                      label: _navigationItems[index].label,
                      isActive: _currentIndex == index,
                      onTap: () => _onItemTapped(index),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpotlightIndicator() {
    double indicatorSize = _indicatorSize.width * 1.5;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.elasticOut,
      top: (_indicatorSize.height / 2) - (indicatorSize / 2),
      left:
          _indicatorPosition.dx +
          (_indicatorSize.width / 2) -
          (indicatorSize / 2),
      width: indicatorSize,
      height: indicatorSize,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _isIndicatorReady ? 1.0 : 0.0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [AppTheme.cPrimary.withOpacity(0.25), Colors.transparent],
              stops: const [0.0, 0.8],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  final bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = MediaQuery.of(context).size.width * 0.02;

    return Tooltip(
      message: widget.label,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(30),
        hoverColor: Colors.transparent,
        splashColor: AppTheme.cPrimary.withOpacity(0.2),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 10,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()
              ..translate(0.0, (_isHovered && !widget.isActive) ? -4.0 : 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: widget.isActive
                      ? AppTheme.cPrimary
                      : AppTheme.cSecondary,
                  size: 22,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.isActive ? Colors.white : AppTheme.cSecondary,
                    fontSize: 12,
                    fontWeight: widget.isActive
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
