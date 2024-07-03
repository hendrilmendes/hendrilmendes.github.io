part of '../main_section.dart';

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer();

  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return Drawer(
      child: Material(
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 25.0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: NavBarLogo(),
              ),
              const Divider(),
              ...NavBarUtils.names.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          scrollProvider.scrollMobile(e.key);
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          leading: Icon(
                            NavBarUtils.icons[e.key],
                          ),
                          title: Text(
                            e.value,
                            style: AppText.l1,
                          ),
                        ),
                      ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FilledButton.tonal(
                  onPressed: () => openURL(StaticUtils.resume),
                  child: const ListTile(
                    leading: Icon(
                      Icons.book_outlined,
                      color: Color.fromARGB(255, 17, 0, 255),
                    ),
                    title: Text(
                      "CURRICULUM",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
