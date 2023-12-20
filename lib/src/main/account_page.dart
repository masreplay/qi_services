import 'package:qi_services/common_lib.dart';
import 'package:useful_hook/useful_hook.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.account),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              childAspectRatio: 11 / 9,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: [
                AccountGridTile(
                  title: const Text('Money Transfer'),
                  icon: const Icon(
                    Icons.swap_horiz_outlined,
                    color: Color(0xff9D88EB),
                  ),
                  onTap: () {},
                ),
                AccountGridTile(
                  title: const Text('Account Information'),
                  icon: const Icon(
                    Icons.settings_rounded,
                    color: Color(0xffFA7068),
                  ),
                  onTap: () {},
                ),
                AccountGridTile(
                  title: const Text('Linked Cards'),
                  icon: const Icon(
                    Icons.credit_card,
                    color: Color(0xffEECD0A),
                  ),
                  onTap: () {},
                ),
                AccountGridTile(
                  title: const Text('Update Account'),
                  icon: const Icon(
                    Icons.autorenew_rounded,
                    color: Color(0xff787774),
                  ),
                  onTap: () {},
                ),
                AccountGridTile(
                  title: const Text('Financial Transactions'),
                  icon: const Icon(
                    Icons.list_outlined,
                    color: Color(0xff0C9089),
                  ),
                  onTap: () {},
                ),
                AccountGridTile(
                  title: const Text('Update Information'),
                  icon: const Icon(
                    Icons.sync_problem_outlined,
                    color: Color(0xffEECD0A),
                  ),
                  onTap: () {},
                ),
                AccountGridTile(
                  title: const Text('AL-Rafidain Loans'),
                  icon: const Icon(Icons.flutter_dash),
                  backgroundColor: const Color(0xff34A853),
                  foregroundColor: Colors.white,
                  onTap: () {},
                ),
                AccountGridTile(
                  title: const Text('Track Requests'),
                  icon: const Icon(
                    Icons.flutter_dash,
                    color: Color(0xffC06981),
                  ),
                  backgroundColor: const Color(0xffF7CBD8),
                  onTap: () {},
                ),
                AccountGridTile(
                  title: const Text('Track Requests'),
                  icon: const Icon(Icons.flutter_dash),
                  backgroundColor: const Color(0xffA85BF5),
                  foregroundColor: Colors.white,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: 11 / 3,
                child: Placeholder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountGridTile extends StatelessWidget {
  const AccountGridTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Widget title;
  final Widget icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.0);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = this.backgroundColor ?? colorScheme.surfaceVariant;
    final foregroundColor = this.foregroundColor ?? colorScheme.onSurface;

    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      color: backgroundColor,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          child: IconTheme(
            data: IconThemeData(color: foregroundColor),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 16.0,
                color: foregroundColor,
              ),
              child: ColumnPadded(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: SizedBox.square(
                      dimension: 24.0,
                      child: icon,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: title),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 16.0,
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
}
