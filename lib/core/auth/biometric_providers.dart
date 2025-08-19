import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'biometric_service.dart';
import 'local_biometric_service.dart';

/// Provider for the biometric authentication service
final biometricServiceProvider = Provider<BiometricService>((ref) {
  // Create the appropriate service implementation
  final service = LocalBiometricService();

  return _AnalyticsBiometricServiceProxy(service);
});

/// A proxy service that adds analytics logging to biometric operations
class _AnalyticsBiometricServiceProxy implements BiometricService {
  _AnalyticsBiometricServiceProxy(this._delegate);
  final BiometricService _delegate;

  @override
  Future<bool> isAvailable() {
    return _delegate.isAvailable();
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() {
    return _delegate.getAvailableBiometrics();
  }

  @override
  Future<BiometricResult> authenticate({
    required String localizedReason,
    AuthReason reason = AuthReason.appAccess,
    bool sensitiveTransaction = false,
    String? dialogTitle,
    String? cancelButtonText,
  }) async {
    final result = await _delegate.authenticate(
      localizedReason: localizedReason,
      reason: reason,
      sensitiveTransaction: sensitiveTransaction,
      dialogTitle: dialogTitle,
      cancelButtonText: cancelButtonText,
    );

    return result;
  }
}

/// Provider to check if biometric authentication is available
final biometricsAvailableProvider = FutureProvider<bool>((ref) {
  final service = ref.watch(biometricServiceProvider);
  return service.isAvailable();
});

/// Provider to get available biometric types
final availableBiometricsProvider = FutureProvider<List<BiometricType>>((ref) {
  final service = ref.watch(biometricServiceProvider);
  return service.getAvailableBiometrics();
});

/// Controller for managing authentication state
class BiometricAuthController extends ChangeNotifier {
  BiometricAuthController(this._service);
  final BiometricService _service;

  bool _isAuthenticated = false;
  BiometricResult? _lastResult;
  DateTime? _lastAuthTime;

  /// Whether the user is currently authenticated
  bool get isAuthenticated => _isAuthenticated;

  /// The result of the last authentication attempt
  BiometricResult? get lastResult => _lastResult;

  /// When the user was last authenticated
  DateTime? get lastAuthTime => _lastAuthTime;

  /// Authenticate the user with biometrics
  Future<BiometricResult> authenticate({
    required String reason,
    AuthReason authReason = AuthReason.appAccess,
    bool sensitiveTransaction = false,
    String? dialogTitle,
    String? cancelButtonText,
  }) async {
    _lastResult = await _service.authenticate(
      localizedReason: reason,
      reason: authReason,
      sensitiveTransaction: sensitiveTransaction,
      dialogTitle: dialogTitle,
      cancelButtonText: cancelButtonText,
    );

    if (_lastResult == BiometricResult.success) {
      _isAuthenticated = true;
      _lastAuthTime = DateTime.now();
    }

    notifyListeners();
    return _lastResult!;
  }

  /// Clear the authenticated state
  void logout() {
    _isAuthenticated = false;
    _lastAuthTime = null;

    notifyListeners();
  }

  /// Check if authentication is needed (based on timeout)
  bool isAuthenticationNeeded({Duration? timeout}) {
    if (!_isAuthenticated) return true;

    if (timeout != null && _lastAuthTime != null) {
      final now = DateTime.now();
      final sessionExpiry = _lastAuthTime!.add(timeout);
      if (now.isAfter(sessionExpiry)) {
        _isAuthenticated = false;
        return true;
      }
    }

    return false;
  }
}

/// Provider for the biometric auth controller
final biometricAuthControllerProvider =
    ChangeNotifierProvider<BiometricAuthController>((ref) {
      final service = ref.watch(biometricServiceProvider);
      return BiometricAuthController(service);
    });
