import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/auth_status.dart';
import 'package:niagara_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:niagara_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository extends BaseRepository implements IAuthRepository {
  AuthRepository({
    required IAuthLocalDataSource localDataSource,
    required IAuthRemoteDatasource remoteDatasource,
    required super.logger,
  })  : _localDataSource = localDataSource,
        _remoteDatasource = remoteDatasource;

  final IAuthLocalDataSource _localDataSource;
  final IAuthRemoteDatasource _remoteDatasource;

  /// Кешируем номер телефона, чтобы избежать нескольких запросов к хранилищам.
  String? _cachedPhone;

  @override
  Future<Either<Failure, AuthenticatedStatus>> checkAuthStatus() =>
      execute(_checkAuthStatus, const CheckAuthStatusFailure());

  @override
  Future<Either<Failure, void>> sendPhone({required String phone}) =>
      execute(() => _sendPhone(phone), const CreateCodeFailure());

  @override
  Future<Either<Failure, void>> skipAuth() {
    return execute(_skipAuth, const SkipAuthFailure());
  }

  @override
  Future<Either<Failure, void>> resendCode() {
    if (_cachedPhone == null) {
      return Future.value(const Left(ResendCodeFailure()));
    }

    return execute(() => _sendPhone(_cachedPhone!), const ResendCodeFailure());
  }

  @override
  Future<Either<Failure, void>> checkCode({required String code}) {
    return execute(() => _checkCode(code), const ValidateCodeFailure());
  }

  Future<AuthenticatedStatus> _checkAuthStatus() async {
    return _localDataSource
        .checkAuthStatus()
        .then((value) => AuthenticatedStatus.values[value]);
  }

  Future<void> _sendPhone(String phone) async {
    _cachedPhone = phone;
    return _remoteDatasource.onCreateCode(phone: phone).fold(
      (failure) => throw CreateCodeFailure(failure.error),
      (isValid) {
        if (!isValid) throw const CreateCodeFailure();
        return;
      },
    );
  }

  Future<void> _checkCode(String code) async {
    if (_cachedPhone == null) throw const PhoneNotFoundFailure();

    return _remoteDatasource
        .onConfirmCode(phone: _cachedPhone!, code: code)
        .fold(
      (failure) => throw ValidateCodeFailure(failure.error),
      (success) {
        if (!success) throw const ValidateCodeFailure();
        _localDataSource.setAuthStatus(
          status: AuthenticatedStatus.authenticated.index,
        );
        _cachedPhone = null;
      },
    );
  }

  Future<void> _skipAuth() {
    return _localDataSource.setAuthStatus(
      status: AuthenticatedStatus.unauthenticated.index,
    );
  }
}
