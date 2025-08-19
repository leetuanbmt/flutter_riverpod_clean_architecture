// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter_riverpod_clean_architecture/features/auth/presentation/screens/login_screen.dart'
    as _i2;
import 'package:flutter_riverpod_clean_architecture/features/auth/presentation/screens/register_screen.dart'
    as _i3;
import 'package:flutter_riverpod_clean_architecture/features/settings/presentation/screens/language_settings_screen.dart'
    as _i1;
import 'package:flutter_riverpod_clean_architecture/features/settings/presentation/screens/settings_screen.dart'
    as _i4;

/// generated route for
/// [_i1.LanguageSettingsScreen]
class LanguageSettingsRoute extends _i5.PageRouteInfo<void> {
  const LanguageSettingsRoute({List<_i5.PageRouteInfo>? children})
    : super(LanguageSettingsRoute.name, initialChildren: children);

  static const String name = 'LanguageSettingsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.LanguageSettingsScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.RegisterScreen]
class RegisterRoute extends _i5.PageRouteInfo<void> {
  const RegisterRoute({List<_i5.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i4.SettingsScreen]
class SettingsRoute extends _i5.PageRouteInfo<void> {
  const SettingsRoute({List<_i5.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SettingsScreen();
    },
  );
}
