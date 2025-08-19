import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../l10n/l10n.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr('settings'))),
      body: ListView(
        children: [
          // Language settings
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.tr('language')),
            subtitle: Text(context.tr('change_language')),
            onTap: () => context.pushRoute(const LanguageSettingsRoute()),
          ),

          const Divider(),

          // Theme settings
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(context.tr('theme')),
            subtitle: Text(context.tr('change_theme')),
            onTap: () {
              // Theme settings (to be implemented)
            },
          ),

          const Divider(),

          // Other settings...
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(context.tr('notifications')),
            subtitle: Text(context.tr('notification_settings')),
            onTap: () {
              // Notification settings (to be implemented)
            },
          ),

          const Divider(),

          // Localization demos
          // ListTile(
          //   leading: const Icon(Icons.language),
          //   title: Text(context.tr('localization_demo')),
          //   subtitle: Text(context.tr('localization_demo_description')),
          //   onTap: () => context.go(AppConstants.localizationAssetsDemoRoute),
          // ),
        ],
      ),
    );
  }
}
