import 'package:qi_services/common_lib.dart';
import 'package:useful_hook/useful_hook.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.services),
      ),
      body: GridView(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 11 / 9,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        children: [
          ServiceGridTile(
            icon: const Icon(Icons.account_balance),
            title: const Text("أصدار بطاقة"),
            gradient: const [
              Color(0xff4187BA),
              Color(0xff1A5582),
            ],
            onTap: () {},
          ),
          ServiceGridTile(
            icon: const Icon(Icons.card_giftcard),
            title: const Text("البطاقات الخاصة"),
            gradient: const [
              Color(0xffF37744),
              Color(0xffF84D59),
            ],
            onTap: () {},
          ),
          ServiceGridTile(
            icon: const Icon(Icons.flutter_dash),
            title: const Text("دجتل زون"),
            gradient: const [
              Color(0xff1BCA8E),
              Color(0xff14A0B2),
            ],
            onTap: () {},
          ),
          ServiceGridTile(
            icon: const Icon(Icons.flutter_dash),
            title: const Text("اقساطي"),
            gradient: const [
              Color(0xff20B5F1),
              Color(0xff1A7ADA),
            ],
            onTap: () {},
          ),
          ServiceGridTile(
            icon: const Icon(Icons.flutter_dash),
            title: const Text("اماكن كي"),
            gradient: const [
              Color(0xffFDCA0C),
              Color(0xffF9AD1C),
            ],
            onTap: () {},
          ),
          ServiceGridTile(
            icon: const Icon(Icons.flutter_dash),
            title: const Text("تسديد"),
            gradient: const [
              Color(0xff108176),
              Color(0xff18B6A2),
            ],
            onTap: () {},
          ),
          ServiceGridTile(
            icon: const Icon(Icons.flutter_dash),
            title: const Text("سلفتي"),
            gradient: const [
              Color(0xff5F60FC),
              Color(0xff933BF6),
            ],
            onTap: () {},
          ),
          ServiceGridTile(
            icon: const Icon(Icons.flutter_dash),
            title: const Text("قروض الرافدين"),
            gradient: const [
              Color(0xff2BA045),
              Color(0xff42BE64),
            ],
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ServiceGridTile extends StatelessWidget {
  const ServiceGridTile({
    super.key,
    required this.icon,
    required this.title,
    required this.gradient,
    this.onTap,
  }) : assert(gradient.length == 2);

  final Widget icon;
  final Widget title;
  final List<Color> gradient;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var foregroundColor = const Color(0xFFFFFFFF);

    final borderRadius = BorderRadius.circular(16.0);

    return IconTheme(
      data: IconThemeData(
        color: foregroundColor,
        size: 36.0,
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
            ),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Ink(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradient,
              ),
            ),
            child: ColumnPadded(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: foregroundColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: foregroundColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox.square(
                      dimension: 48.0,
                      child: icon,
                    ),
                  ),
                ),
                title,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
