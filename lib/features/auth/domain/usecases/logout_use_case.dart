import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, void>> execute() {
    return _repository.logout();
  }
}

// Provider
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
});
