// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_code.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAreaCodesHash() => r'de527b80a5ecbfa9f94cf40dd45f31209cdbd2bc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getAreaCodes].
@ProviderFor(getAreaCodes)
const getAreaCodesProvider = GetAreaCodesFamily();

/// See also [getAreaCodes].
class GetAreaCodesFamily extends Family<List<AreaCode>> {
  /// See also [getAreaCodes].
  const GetAreaCodesFamily();

  /// See also [getAreaCodes].
  GetAreaCodesProvider call(
    String query,
  ) {
    return GetAreaCodesProvider(
      query,
    );
  }

  @override
  GetAreaCodesProvider getProviderOverride(
    covariant GetAreaCodesProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getAreaCodesProvider';
}

/// See also [getAreaCodes].
class GetAreaCodesProvider extends AutoDisposeProvider<List<AreaCode>> {
  /// See also [getAreaCodes].
  GetAreaCodesProvider(
    String query,
  ) : this._internal(
          (ref) => getAreaCodes(
            ref as GetAreaCodesRef,
            query,
          ),
          from: getAreaCodesProvider,
          name: r'getAreaCodesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAreaCodesHash,
          dependencies: GetAreaCodesFamily._dependencies,
          allTransitiveDependencies:
              GetAreaCodesFamily._allTransitiveDependencies,
          query: query,
        );

  GetAreaCodesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    List<AreaCode> Function(GetAreaCodesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAreaCodesProvider._internal(
        (ref) => create(ref as GetAreaCodesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<AreaCode>> createElement() {
    return _GetAreaCodesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAreaCodesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAreaCodesRef on AutoDisposeProviderRef<List<AreaCode>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _GetAreaCodesProviderElement
    extends AutoDisposeProviderElement<List<AreaCode>> with GetAreaCodesRef {
  _GetAreaCodesProviderElement(super.provider);

  @override
  String get query => (origin as GetAreaCodesProvider).query;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
