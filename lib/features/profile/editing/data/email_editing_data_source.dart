import 'package:niagara_app/core/core.dart';

abstract interface class IEmailConfirmationDataSource {
  /// Генерирует код подтверждения электронной почты [email].
  ///
  /// Возвращает статус операции [bool] или [Failure] в случае ошибки.
  Future<Either<Failure, bool>> createEmailCode({required String email});

  /// Проверяет код аутентификации [code] для заданного [email].
  ///
  /// Возвращает статус операции [bool] или [Failure] в случае ошибки.
  Future<Either<Failure, bool>> confirmEmailCode({
    required String email,
    required String code,
  });
}

@LazySingleton(as: IEmailConfirmationDataSource)
class EmailConfirmationDataSource implements IEmailConfirmationDataSource {
  EmailConfirmationDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, bool>> createEmailCode({required String email}) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kCreateEmailCode,
          data: {
            'EMAIL': email,
          },
        ),
        converter: (json) => json['success'] as bool? ?? false,
        failure: EmailCreateCodeFailure.new,
      );

  @override
  Future<Either<Failure, bool>> confirmEmailCode({
    required String email,
    required String code,
  }) =>
      _requestHandler.sendRequest<bool, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kConfirmEmail,
          data: {
            'email': email,
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
        failure: EmailConfirmCodeFailure.new,
      );
}
