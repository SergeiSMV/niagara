import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';

@injectable
/// UseCase для проверки авторизован ли пользователь
class CheckAuthUserUseCase extends UseCase<bool, NoParams> {
  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return Future.value(const Right(false));
  }
}
