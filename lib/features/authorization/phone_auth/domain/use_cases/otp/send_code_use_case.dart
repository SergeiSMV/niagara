import '../../../../../../core/core.dart';
import '../../repositories/auth_repository.dart';

/// Отправляет номер телефона.
///
/// Возвращает:
/// - [void] если номер телефона был отправлен.
/// - [Failure] если номер телефона не был отправлен.
@injectable
class SendPhoneUseCase extends BaseUseCase<void, SendPhoneParams> {
  SendPhoneUseCase(this._repository);

  /// Репозиторий для работы с аутентификацией
  final IAuthRepository _repository;

  /// Отправляет номер телефона
  @override
  Future<Either<Failure, void>> call(SendPhoneParams params) =>
      _repository.sendPhone(phone: params.phone.replaceAll(RegExp(r'\D'), ''));
}

/// Параметры для отправки кода на телефон
class SendPhoneParams extends Equatable {
  const SendPhoneParams({
    required this.phone,
  });

  /// Номер телефона
  final String phone;

  @override
  List<Object?> get props => [phone];
}
