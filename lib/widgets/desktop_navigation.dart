// ignore_for_file: deprecated_member_use, library_private_types_in_public_api

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:folio/configs/app_theme.dart';
import 'package:folio/screens/contact/contact.dart';
import 'package:folio/screens/education/education.dart';
import 'package:folio/screens/home/home.dart';
import 'package:folio/screens/projects/projects.dart';
import 'package:folio/screens/skills/skills.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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

  final GlobalKey _navBarKey = GlobalKey();
  final List<GlobalKey> _navItemKeys = List.generate(5, (_) => GlobalKey());

  Offset _indicatorPosition = Offset.zero;
  Size _indicatorSize = Size.zero;
  bool _isIndicatorReady = false;

  final List<Widget> _pages = const [
    HomeScreen(),
    EducationScreen(),
    ProjectsScreen(),
    SkillsScreen(),
    ContactScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateIndicatorPosition(0, isInitial: true);
      }
    });
  }

  void _updateIndicatorPosition(int index, {bool isInitial = false}) {
    if (!mounted || _navItemKeys[index].currentContext == null) return;

    final RenderBox navBarBox =
        _navBarKey.currentContext!.findRenderObject() as RenderBox;
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

  void _onItemTapped(int index) {
    if (_currentIndex == index) return;
    setState(() => _currentIndex = index);
    _updateIndicatorPosition(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.cBackground,
      body: Stack(
        children: [
          PageTransitionSwitcher(
            duration: 500.ms,
            transitionBuilder: (child, primary, secondary) =>
                FadeThroughTransition(
                  animation: primary,
                  secondaryAnimation: secondary,
                  child: child,
                ),
            child: _pages[_currentIndex],
          ),

          _buildFloatingTopBar(),
          _buildProfessionalFooter(),
        ],
      ),
    );
  }

  Widget _buildFloatingTopBar() {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              key: _navBarKey,
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      5,
                      (index) => _NavItem(
                        key: _navItemKeys[index],
                        icon: [
                          MdiIcons.homeVariant,
                          MdiIcons.school,
                          MdiIcons.folderStar,
                          MdiIcons.starCircle,
                          MdiIcons.email,
                        ][index],
                        label: [
                          'Home',
                          'Formação',
                          'Projetos',
                          'Skills',
                          'Contato',
                        ][index],
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
      ),
    );
  }

  Widget _buildSpotlightIndicator() {
    const indicatorHeight = 90.0;
    const indicatorWidth = 90.0;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.elasticOut,
      top: (_indicatorSize.height / 2) - (indicatorHeight / 2),
      left:
          _indicatorPosition.dx +
          (_indicatorSize.width / 2) -
          (indicatorWidth / 2),
      width: indicatorWidth,
      height: indicatorHeight,
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

  Widget _buildProfessionalFooter() {
    double navBarWidth = MediaQuery.of(context).size.width < 900 ? 100 : 850;

    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              height: 50,
              width: navBarWidth,
              constraints: const BoxConstraints(maxWidth: 850),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.05),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusIndicator(),
                  Row(
                    children: [
                      _ClockWidget(),
                      VerticalDivider(
                        color: AppTheme.cSecondary.withOpacity(0.3),
                        indent: 12,
                        endIndent: 12,
                        width: 30,
                      ),
                      _FooterSocialButton(
                        icon: MdiIcons.github,
                        url: 'https://github.com/hendrilmendes',
                      ),
                      _FooterSocialButton(
                        icon: MdiIcons.linkedin,
                        url: 'https://linkedin.com/in/hendril-mendes',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xff00ff84),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff00ff84).withOpacity(0.5),
                blurRadius: 8.0,
              ),
            ],
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true)),
        const SizedBox(width: 12),
        Text(
          'Disponível para trabalho | © $_currentYear Hendril Mendes',
          style: TextStyle(color: AppTheme.cSecondary, fontSize: 12),
        ),
      ],
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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(30),
          hoverColor: Colors.transparent,
          splashColor: AppTheme.cPrimary.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                      color: widget.isActive
                          ? Colors.white
                          : AppTheme.cSecondary,
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
      ),
    );
  }
}

class _FooterSocialButton extends StatefulWidget {
  final IconData icon;
  final String url;
  const _FooterSocialButton({required this.icon, required this.url});

  @override
  State<_FooterSocialButton> createState() => _FooterSocialButtonState();
}

class _FooterSocialButtonState extends State<_FooterSocialButton> {
  bool _isHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Não foi possível abrir a URL: $url';
  }

  @override
  Widget build(BuildContext context) {
    final color = _isHovered ? AppTheme.cPrimary : AppTheme.cSecondary;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: IconButton(
        icon: Icon(widget.icon, color: color, size: 20),
        onPressed: () => _launchURL(widget.url),
        splashRadius: 20,
        tooltip: widget.url.contains('github') ? 'GitHub' : 'LinkedIn',
      ),
    );
  }
}

class _ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<_ClockWidget> {
  String _timeString = "";
  late Timer _timer;

  @override
  void initState() {
    _timeString = DateFormat('HH:mm:ss').format(DateTime.now());
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => _getTime(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getTime() {
    if (mounted) {
      setState(
        () => _timeString = DateFormat('HH:mm:ss').format(DateTime.now()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(MdiIcons.clockOutline, color: AppTheme.cSecondary, size: 16),
        const SizedBox(width: 8),
        Text(
          _timeString,
          style: TextStyle(color: AppTheme.cSecondary, fontSize: 12),
        ),
      ],
    );
  }
}
