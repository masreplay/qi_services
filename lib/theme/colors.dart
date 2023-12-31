import 'package:qi_services/common_lib.dart';

/// Generic Colors (not effected by theme)
/// never use them for brand colors
abstract final class AppColors {
  // prevent instantiation
  const AppColors._();

  static const Color yellow = Color(0xffF3C202);
  static const Color green = Color(0xff47AD94);
  static const Color purple = Color(0xff9D88EB);
  static const Color vermilion = Color(0xffFA7068);
  static const Color grey = Color(0xff787774);
  static const Color darkPink = Color(0xffC06981);
  static const Color pink = Color(0xffF7CBD8);
  static const Color indigo = Color(0xff1F7DD7);
}
