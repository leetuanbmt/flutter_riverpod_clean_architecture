import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_router.gr.dart';

final routerProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: LanguageSettingsRoute.page),
    AutoRoute(page: SettingsRoute.page),
  ];
}
