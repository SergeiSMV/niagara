import 'package:either_dart/either.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> skipAuth();

  // ! Возвращаемое значение - временное !
  Future<Either<Failure, String>> sendCode({
    required String phone,
  });

  Future<Either<Failure, void>> checkCode({
    required String phone,
    required String code,
  });

  Future<Either<Failure, AuthenticatedStatus>> checkAuthStatus();
}
