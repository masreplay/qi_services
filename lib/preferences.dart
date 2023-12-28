/// Single Source of Truth: Collects all preferences keys in one place
/// it's the best way to avoid typos and mistakes and using the same key
abstract final class Preferences {
  // prevent instantiation
  const Preferences._();

  static const String authentication = "authentication";
  static const String settings = "settings";
  static const String servicesLayoutType = "servicesLayoutType";
}
