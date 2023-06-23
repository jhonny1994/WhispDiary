// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isarInstanceHash() => r'896fbb6edab89a28e65e9e6982ca55248ccf3ec7';

/// See also [isarInstance].
@ProviderFor(isarInstance)
final isarInstanceProvider = FutureProvider<Isar>.internal(
  isarInstance,
  name: r'isarInstanceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isarInstanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsarInstanceRef = FutureProviderRef<Isar>;
String _$diaryManagerHash() => r'ab5272f4f5d2fcb8b490606e8c38cbdf338fe7f2';

/// See also [diaryManager].
@ProviderFor(diaryManager)
final diaryManagerProvider = AutoDisposeFutureProvider<DiaryManager>.internal(
  diaryManager,
  name: r'diaryManagerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$diaryManagerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DiaryManagerRef = AutoDisposeFutureProviderRef<DiaryManager>;
String _$entriesHash() => r'dea1a740204a3a64e1445c76bb182ecba4b26b4b';

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

typedef EntriesRef = AutoDisposeFutureProviderRef<List<Entry>>;

/// See also [entries].
@ProviderFor(entries)
const entriesProvider = EntriesFamily();

/// See also [entries].
class EntriesFamily extends Family<AsyncValue<List<Entry>>> {
  /// See also [entries].
  const EntriesFamily();

  /// See also [entries].
  EntriesProvider call({
    int? limit,
  }) {
    return EntriesProvider(
      limit: limit,
    );
  }

  @override
  EntriesProvider getProviderOverride(
    covariant EntriesProvider provider,
  ) {
    return call(
      limit: provider.limit,
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
  String? get name => r'entriesProvider';
}

/// See also [entries].
class EntriesProvider extends AutoDisposeFutureProvider<List<Entry>> {
  /// See also [entries].
  EntriesProvider({
    this.limit,
  }) : super.internal(
          (ref) => entries(
            ref,
            limit: limit,
          ),
          from: entriesProvider,
          name: r'entriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$entriesHash,
          dependencies: EntriesFamily._dependencies,
          allTransitiveDependencies: EntriesFamily._allTransitiveDependencies,
        );

  final int? limit;

  @override
  bool operator ==(Object other) {
    return other is EntriesProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$isAuthHash() => r'd7000d86a8168505e0e090bcbf87dd0f5fd2aba9';

/// See also [isAuth].
@ProviderFor(isAuth)
final isAuthProvider = AutoDisposeFutureProvider<bool>.internal(
  isAuth,
  name: r'isAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAuthRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
