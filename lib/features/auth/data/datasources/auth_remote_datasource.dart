import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/constants/api_constants.dart';

abstract interface class IAuthRemoteDatasource {
  Future<Either<Failure, (bool, String tempCode)>> onCreateCode({
    required String token,
    required String phone,
  });

  Future<Either<Failure, bool>> onValidateCode({
    required String token,
    required String phone,
    required String code,
  });
}

@LazySingleton(as: IAuthRemoteDatasource)
class AuthRemoteDatasource implements IAuthRemoteDatasource {
  AuthRemoteDatasource({
    required RequestHandler requestHandler,
  }) : _requestHandler = requestHandler;

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, (bool, String tempCode)>> onCreateCode({
    required String token,
    required String phone,
  }) =>
      _requestHandler.sendRequest(
        request: (dio) => dio.post(
          ApiConst.kCreateCode,
          data: {
            'token': token,
            'phone': phone,
          },
        ),
        converter: (json) => (
          json['success'] as bool,
          // ! временное решение по просьбе бэка !
          json['temp_code'] as String,
        ),
        failure: CreateCodeFailure.new,
      );

  @override
  Future<Either<Failure, bool>> onValidateCode({
    required String token,
    required String phone,
    required String code,
  }) =>
      _requestHandler.sendRequest(
        request: (dio) => dio.post(
          ApiConst.kValidateCode,
          data: {
            'token': token,
            'phone': phone,
            'code': code,
          },
        ),
        converter: (json) => json['valid'] as bool,
        failure: ValidateCodeFailure.new,
      );
}
