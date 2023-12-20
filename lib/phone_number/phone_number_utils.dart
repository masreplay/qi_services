import 'area_code.dart';

abstract final class PhoneNumberUtils {
  static String merge({
    required AreaCode areaCode,
    required String mobileNumber,
  }) {
    assert(mobileNumber.isNotEmpty, "Mobile number can't be empty");

    final code = areaCode.code;

    if (code == iraqAreaCode.code && mobileNumber.startsWith("0")) {
      return "$code${mobileNumber.substring(1)}";
    }

    return "$code$mobileNumber";
  }
}
