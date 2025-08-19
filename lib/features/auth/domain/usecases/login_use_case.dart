import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failures.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, UserEntity>> execute({
    required String email,
    required String password,
  }) {
    // Add any validation logic here if needed
    if (email.isEmpty || password.isEmpty) {
      return Future.value(
        const Left(InputFailure(message: 'Email and password cannot be empty')),
      );
    }

    return _repository.login(email: email, password: password);
  }
}

// Provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});
