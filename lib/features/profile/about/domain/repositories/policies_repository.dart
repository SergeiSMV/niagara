import '../../../../../core/core.dart';
import '../../../../../core/utils/enums/policy_type.dart';
import '../model/policy.dart';

/// Интерфейс для работы с политикой конфиденциальности и маркетинговым
/// соглашением
abstract interface class IPoliciesRepository {
  /// Получение политики конфиденциальности или маркетингового соглашения
  ///
  /// - [type] тип политики (marketing или application)
  ///
  /// Возвращает:
  /// - [Either] результат запроса (успешно или с ошибкой)
  Future<Either<Failure, Policy>> getPolicy({required PolicyType type});
}
