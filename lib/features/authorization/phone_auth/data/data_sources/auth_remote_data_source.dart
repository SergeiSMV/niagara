import 'dart:io';

import '../../../../../core/core.dart';

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

  /// Метод для подтверждения privacy policy после успешной валидации кода
  ///
  /// - [user] согласие на обработку персональных данных
  /// - [marketing] согласие на маркетинговые коммуникации
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, было ли подтверждение успешным.
  /// - [Failure] в случае ошибки.
  Future<Either<Failure, bool>> confirmPrivacy({
    required bool user,
    required bool marketing,
  });

  /// Метод `logout` производит выход из аккаунта.
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, был ли выход из аккаунта успешным.
  /// - [Failure] в случае ошибки.
  Future<Either<Failure, bool>> logout();
}

/// Реализация интерфейса [IAuthRemoteDatasource] для удаленного источника данных
/// аутентификации.
///
/// Этот класс предоставляет методы для создания и проверки кодов
/// аутентификации, а также для подтверждения согласия на обработку персональных
/// данных и маркетинговых коммуникаций
@LazySingleton(as: IAuthRemoteDatasource)
class AuthRemoteDataSource implements IAuthRemoteDatasource {
  AuthRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  /// Метод `onCreateCode` генерирует временный код аутентификации для заданного
  /// номера телефона и токена.
  ///
  /// - [phone] номер телефона, для которого создается код.
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, был ли код создан успешно.
  /// - [Failure] в случае ошибки.
  @override
  Future<Either<Failure, bool>> onCreateCode({
    required String phone,
  }) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kCreateCode,
          data: {
            'phone': phone,
            'platform': Platform.isIOS ? 'ios' : 'android',
          },
        ),
        converter: (json) => json['success'] as bool? ?? false,
        failure: CreateCodeFailure.new,
      );

  /// Метод `onConfirmCode` проверяет код аутентификации для заданного номера
  /// телефона, токена и кода.
  ///
  /// - [phone] номер телефона, для которого проверяется код.
  /// - [code] код аутентификации.
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, был ли код аутентификации верным.
  /// - [Failure] в случае ошибки.
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

  /// Метод для передачи информации о согласии на обработку персональных данных
  /// и маркетинговых коммуникаций
  ///
  /// - [user] согласие на обработку персональных данных
  /// - [marketing] согласие на маркетинговые коммуникации
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, было ли подтверждение успешным.
  /// - [Failure] в случае ошибки.
  @override
  Future<Either<Failure, bool>> confirmPrivacy({
    required bool user,
    required bool marketing,
  }) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kConfirmPrivacy,
          data: {
            'user': user,
            'marketing': marketing,
          },
        ),
        converter: (json) {
          final response = json['response'] as Map<String, dynamic>?;
          return response?['success'] as bool? ?? false;
        },
        failure: ConfirmPrivacyFailure.new,
      );

  /// Метод `logout` производит выход из аккаунта.
  ///
  /// Возвращает:
  /// - [bool] значение, указывающее, был ли выход из аккаунта успешным.
  /// - [Failure] в случае ошибки
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
