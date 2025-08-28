import '../../../../../../core/core.dart';
import '../../../../../../core/utils/enums/policy_type.dart';
import '../dto/policy_dto.dart';

/// Интерфейс для работы с удаленными данными о политике конфиденциальности
/// и маркетинговом соглашении
abstract interface class IPoliciesRemoteDataSource {
  /// Получение политики конфиденциальности или маркетингового соглашения
  ///
  /// - [type] тип политики (marketing или application)
  ///
  /// Возвращает:
  /// - [Either] результат запроса (успешно или с ошибкой)
  Future<Either<Failure, PolicyDto>> getPolicy({required String type});
}

/// Реализация интерфейса [IPoliciesRemoteDataSource] для работы с удаленными
/// данными о политике конфиденциальности и маркетинговом соглашении
@LazySingleton(as: IPoliciesRemoteDataSource)
class PoliciesRemoteDataSource implements IPoliciesRemoteDataSource {
  PoliciesRemoteDataSource(this._requestHandler);

  /// Обработчик запросов
  final RequestHandler _requestHandler;

  /// Получение политики конфиденциальности или маркетингового соглашения
  @override
  Future<Either<Failure, PolicyDto>> getPolicy({
    required String type,
  }) =>
      _requestHandler.sendRequest<PolicyDto, String>(
        isHtml: true,
        request: (dio) {
          if (type == PolicyType.marketing) {
            return dio.get(ApiConst.kGetMarketingPolicy);
          } else {
            return dio.get(
              ApiConst.kGetPolicies,
              queryParameters: {
                'type': type,
              },
            );
          }
        },
        converter: (html) => PolicyDto(html: html),
        failure: PolicieslRemoteDataFailure.new,
      );
}
