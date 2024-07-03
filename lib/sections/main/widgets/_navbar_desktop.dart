part of '../main_section.dart';

class _NavbarDesktop extends StatelessWidget {
  const _NavbarDesktop();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Space.all(),
      color: Colors.black,
      child: Row(
        children: [
          const NavBarLogo(),
          Space.xm!,
          ...NavBarUtils.names.asMap().entries.map(
                (entry) => NavBarActionButton(
                  label: entry.value,
                  index: entry.key,
                ),
              ),
          EntranceFader(
            offset: const Offset(0, -10),
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 250),
            child: ElevatedButton(
              onPressed: () {
                html.window.open(StaticUtils.resume, "pdf");
              },
              child: Padding(
                padding: Space.all(1.25, 0.45),
                child: Text(
                  'CURRICULUM',
                  style: AppText.l1b,
                ),
              ),
            ),
          ),
          Space.x!,
        ],
      ),
    );
  }
}

class _NavBarTablet extends StatelessWidget {
  const _NavBarTablet();

  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);

    return Padding(
      padding: Space.v!,
      child: Row(
        children: [
          Space.x1!,
          IconButton(
            highlightColor: Colors.white,
            splashRadius: AppDimensions.normalize(10),
            onPressed: () {
              drawerProvider.key.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu_outlined,
            ),
          ),
          Space.xm!,
          const NavBarLogo(),
          Space.x1!,
        ],
      ),
    );
  }
}
