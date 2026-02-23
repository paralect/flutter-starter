// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appThemeHash() => r'22a4fe9a0eecf0654c60e23bd23fe670bb9bae3b';

/// See also [appTheme].
@ProviderFor(appTheme)
final appThemeProvider = AutoDisposeProvider<ThemeData>.internal(
  appTheme,
  name: r'appThemeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppThemeRef = AutoDisposeProviderRef<ThemeData>;
String _$appThemeModeValueHash() => r'407ee915522c0350c9ccd0127ed673a37d333535';

/// See also [appThemeModeValue].
@ProviderFor(appThemeModeValue)
final appThemeModeValueProvider = AutoDisposeProvider<ThemeMode>.internal(
  appThemeModeValue,
  name: r'appThemeModeValueProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appThemeModeValueHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppThemeModeValueRef = AutoDisposeProviderRef<ThemeMode>;
String _$appThemeModeHash() => r'065931154d0db857f28893c3f966643a54dc6630';

/// See also [AppThemeMode].
@ProviderFor(AppThemeMode)
final appThemeModeProvider =
    AutoDisposeNotifierProvider<AppThemeMode, bool>.internal(
      AppThemeMode.new,
      name: r'appThemeModeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appThemeModeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppThemeMode = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
