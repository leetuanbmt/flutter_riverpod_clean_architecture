import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_constants.dart';
import 'core/providers/localization_providers.dart';
import 'core/providers/storage_providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations_delegate.dart';
import 'l10n/l10n.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Run the app with ProviderScope to enable Riverpod
  runApp(
    ProviderScope(
      overrides: [
        // Override the shared preferences provider with the instance
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),

        // Override the default locale provider to use our persistent locale
        defaultLocaleProvider.overrideWith(
          (ref) => ref.watch(persistentLocaleProvider),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the router from provider
    final router = ref.watch(routerProvider);

    // Watch the theme mode
    final themeMode = ref.watch(themeModeProvider);

    // Watch the persistent locale
    final locale = ref.watch(persistentLocaleProvider);
    return MaterialApp.router(
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router.config(),
      debugShowCheckedModeBanner: false,
      // Localization settings
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
