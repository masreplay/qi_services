import 'area_code.dart';

abstract final class PhoneNumberConvertor {
  RegExp iraqLocalePhoneRegex() {
    return RegExp(r"07[3-9][0-9]{8}");
  }

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
