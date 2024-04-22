import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/auth/domain/repositories/auth_repository.dart';

/// Отправляет номер телефона.
///
/// Возвращает:
/// - [void] если номер телефона был отправлен.
/// - [Failure] если номер телефона не был отправлен.
@injectable
class SendPhoneUseCase extends BaseUseCase<void, SendPhoneParams> {
  SendPhoneUseCase({
    required IAuthRepository repository,
  }) : _repository = repository;

  final IAuthRepository _repository;

  @override
  Future<Either<Failure, void>> call(SendPhoneParams params) =>
      _repository.sendPhone(phone: params.phone.replaceAll(RegExp(r'\D'), ''));
}

class SendPhoneParams extends Equatable {
  const SendPhoneParams({
    required this.phone,
  });

  final String phone;

  @override
  List<Object?> get props => [phone];
}
