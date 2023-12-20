import 'package:qi_services/common_lib.dart';
import 'package:useful_hook/useful_hook.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      color: Colors.grey,
      height: 1.0,
      indent: 16.0,
      endIndent: 16.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.more),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("+9647700000000"),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ColumnPadded(
                spacing: 4.0,
                children: [
                  _MoreListTile(
                    titleText: "Settings",
                    leading: const _MoreIcon(
                      icon: Icons.settings,
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xffF6676C),
                    ),
                    onTap: () {},
                  ),
                  divider,
                  _MoreListTile(
                    titleText: "Share",
                    leading: _MoreIcon(
                      icon: Icons.adaptive.share,
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xff3EB294),
                    ),
                    onTap: () {},
                  ),
                  divider,
                  _MoreListTile(
                    titleText: "Rate Us",
                    leading: const _MoreIcon(
                      icon: Icons.star,
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xffF3C202),
                    ),
                    onTap: () {},
                  ),
                  divider,
                  _MoreListTile(
                    titleText: "Rate Call Center Service",
                    leading: const _MoreIcon(
                      icon: Icons.star,
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff1F7DD7),
                    ),
                    onTap: () {},
                  ),
                  divider,
                  _MoreListTile(
                    titleText: "About Us",
                    leading: const _MoreIcon(
                      icon: Icons.info_outline,
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff1F7DD7),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Spacer(),
            ListTile(
              title: const Text("Logout"),
              tileColor: Theme.of(context).colorScheme.surface,
              onTap: () {},
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.0,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              leading: const _MoreIcon(
                icon: Icons.logout,
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffF6676C),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _MoreListTile extends StatelessWidget {
  const _MoreListTile({
    required this.titleText,
    required this.leading,
    required this.onTap,
  });

  final String titleText;
  final VoidCallback onTap;
  final _MoreIcon leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titleText),
      onTap: onTap,
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16.0,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      leading: leading,
    );
  }
}

class _MoreIcon extends StatelessWidget {
  const _MoreIcon({
    required this.icon,
    required this.foregroundColor,
    required this.backgroundColor,
  });

  final IconData icon;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Icon(
        icon,
        color: foregroundColor,
      ),
    );
  }
}
