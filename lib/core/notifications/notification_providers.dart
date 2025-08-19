import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'debug_notification_service.dart';
import 'notification_service.dart';

/// Provider for the notification service
final notificationServiceProvider = Provider<NotificationService>((ref) {
  // In a real app, you would use a real notification service implementation
  // such as FirebaseNotificationService
  final service = DebugNotificationService();

  // Initialize the service
  service.init();

  return service;
});

/// Provider for whether notifications are enabled
final notificationsEnabledProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(notificationServiceProvider);
  final status = await service.getPermissionStatus();
  return status == NotificationPermissionStatus.authorized ||
      status == NotificationPermissionStatus.provisional;
});

/// Controller for handling deep links from notifications
class NotificationDeepLinkHandler extends ChangeNotifier {
  NotificationDeepLinkHandler(this._service) {
    _service.notificationTapStream.listen(_handleNotificationTap);
  }
  final NotificationService _service;
  String? _pendingDeepLink;

  /// Get the pending deep link, if any
  String? get pendingDeepLink => _pendingDeepLink;

  /// Clear the pending deep link
  void clearPendingDeepLink() {
    _pendingDeepLink = null;
    notifyListeners();
  }

  void _handleNotificationTap(NotificationMessage notification) {
    if (notification.action != null) {
      _pendingDeepLink = notification.action;
      notifyListeners();
    }
  }
}

/// Provider for the notification deep link handler
final notificationDeepLinkHandlerProvider =
    ChangeNotifierProvider<NotificationDeepLinkHandler>((ref) {
      final service = ref.watch(notificationServiceProvider);
      return NotificationDeepLinkHandler(service);
    });
