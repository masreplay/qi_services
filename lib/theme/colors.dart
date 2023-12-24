import 'package:qi_services/common_lib.dart';

/// Generic Colors (not effected by theme)
/// never use them for brand colors
abstract final class AppColors {
  // prevent instantiation
  const AppColors._();
  
  static const Color yellow = Color(0xffEECD0A);
  static const Color turquoise = Color(0xff01C3B8);
  static const Color purple = Color(0xff9D88EB);
  static const Color vermilion = Color(0xffFA7068);
  static const Color grey = Color(0xff787774);
  static const Color darkPink = Color(0xffC06981);
  static const Color pink = Color(0xffF7CBD8);
}
