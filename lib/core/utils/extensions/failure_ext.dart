import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/logger/logger.dart';

/// Расширение для [Failure]. Позволяет логировать ошибку.
extension FailureExt on Failure {
  IAppLogger get _logger => getIt<IAppLogger>();

  /// Вывод ошибки в консоль.
  Failure talk() {
    final who = runtimeType.toString();
    final errorMessage = error ?? 'No error message';
    _logger.warning('$who: $errorMessage');
    return this;
  }
}
