import 'package:niagara_app/core/core.dart';

/// Определяет интерфейс для удаленного источника данных аутентификации.
///
/// Этот интерфейс предоставляет методы для создания и проверки кодов
/// аутентификации.
abstract interface class IAuthRemoteDatasource {
  /// Метод `onCreateCode` генерирует временный код аутентификации для заданного
  /// номера телефона и токена.
  ///
  /// - [phone] номер телефона, для которого создается код.
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, был ли код создан успешно.
  /// - [Failure] в случае ошибки.
  Future<Either<Failure, bool>> onCreateCode({
    required String phone,
  });

  /// Метод `onValidateCode` проверяет код аутентификации для заданного номера
  /// телефона, токена и кода.
  ///
  /// - [phone] номер телефона, для которого проверяется код.
  /// - [code] код аутентификации.
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, был ли код аутентификации верным.
  /// - [Failure] в случае ошибки.
  Future<Either<Failure, bool>> onConfirmCode({
    required String phone,
    required String code,
  });

  /// Метод `logout` производит выход из аккаунта.
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, был ли выход из аккаунта успешным.
  /// - [Failure] в случае ошибки.
  Future<Either<Failure, bool>> logout();
}

@LazySingleton(as: IAuthRemoteDatasource)
class AuthRemoteDataSource implements IAuthRemoteDatasource {
  AuthRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, bool>> onCreateCode({
    required String phone,
  }) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kCreateCode,
          data: {
            'phone': phone,
          },
        ),
        converter: (json) => json['success'] as bool? ?? false,
        failure: CreateCodeFailure.new,
      );

  @override
  Future<Either<Failure, bool>> onConfirmCode({
    required String phone,
    required String code,
  }) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kConfirmCode,
          data: {
            'phone': phone,
            'code': code,
          },
          options: Options(
            validateStatus: (status) {
              if (status == null) return false;
              if (status == 401) return true;
              return status >= 200 && status < 300;
            },
          ),
        ),
        converter: (json) => json['valid'] as bool? ?? false,
        failure: ValidateCodeFailure.new,
      );

  @override
  Future<Either<Failure, bool>> logout() =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kLogout,
        ),
        converter: (json) => json['success'] as bool,
        failure: LogoutFailure.new,
      );
}
