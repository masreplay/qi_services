import 'package:qi_services/common_lib.dart';

class IconButtonFilled extends StatelessWidget {
  const IconButtonFilled({
    super.key,
    required this.icon,
    this.onTap,
    this.foregroundColor,
    this.backgroundColor,
  });

  final Color? foregroundColor, backgroundColor;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: IconButton(
        color: foregroundColor,
        icon: icon,
        onPressed: onTap,
      ),
    );
  }
}