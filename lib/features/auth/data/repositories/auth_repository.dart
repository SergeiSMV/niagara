// ignore_for_file: public_member_api_docs

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:niagara_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository with LogMixin implements IAuthRepository {
  AuthRepository({
    required IAuthLocalDataSource localDataSource,
    required IAuthRemoteDatasource remoteDatasource,
    required ITokenLocalDataSource tokenLocalDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDatasource = remoteDatasource,
        _tokenLocalDataSource = tokenLocalDataSource;

  final IAuthLocalDataSource _localDataSource;
  final IAuthRemoteDatasource _remoteDatasource;
  final ITokenLocalDataSource _tokenLocalDataSource;

  static const String _tokenEmptyError = 'Token is empty';
  static const String _codeInvalidError = 'Code is invalid';

  @override
  Future<Either<Failure, AuthenticatedStatus>> checkAuthStatus() async {
    try {
      final result = await _localDataSource
          .onCheckAuthStatus()
          .then((value) => AuthenticatedStatus.values[value]);
      return Right(result);
    } catch (e, st) {
      return Left(logError(const CheckAuthStatusFailure(), e, st));
    }
  }

  @override
  Future<Either<Failure, String>> sendCode({required String phone}) async {
    try {
      final token = await _tokenLocalDataSource.onGetToken();
      if (token == null) {
        return Left(logFailure(const CreateCodeFailure(_tokenEmptyError)));
      }

      return await _remoteDatasource
          .onCreateCode(
            token: token,
            phone: phone,
          )
          .fold(
            (left) => Left(logFailure(CreateCodeFailure(left.error))),
            (right) => Right(right.$2),
          );
    } catch (e, st) {
      return Left(logError(const CreateCodeFailure(), e, st));
    }
  }

  @override
  Future<Either<Failure, void>> checkCode({
    required String phone,
    required String code,
  }) async {
    try {
      final token = await _tokenLocalDataSource.onGetToken();
      if (token == null) {
        return Left(logFailure(const ValidateCodeFailure(_tokenEmptyError)));
      }

      return await _remoteDatasource
          .onValidateCode(token: token, phone: phone, code: code)
          .fold(
        (left) => Left(logFailure(ValidateCodeFailure(left.error))),
        (right) {
          if (!right) {
            return Left(
              logFailure(const ValidateCodeFailure(_codeInvalidError)),
            );
          }

          _localDataSource.onSetAuthStatus(
            status: AuthenticatedStatus.authenticated.index,
          );
          return const Right(null);
        },
      );
    } catch (e, st) {
      return Left(logError(const ValidateCodeFailure(), e, st));
    }
  }

  @override
  Future<Either<Failure, void>> skipAuth() async {
    try {
      await _localDataSource.onSetAuthStatus(
        status: AuthenticatedStatus.unauthenticated.index,
      );
      return const Right(null);
    } catch (e, st) {
      return Left(logError(const SkipAuthFailure(), e, st));
    }
  }
}
