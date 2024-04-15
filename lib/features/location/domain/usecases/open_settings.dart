import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';

@injectable
class OpenSettingsUseCase extends UseCase<void, NoParams> {
  OpenSettingsUseCase({
    required PermissionsService permissionsService,
  }) : _permissionsService = permissionsService;

  final PermissionsService _permissionsService;

  @override
  Future<Either<Failure, void>> call([NoParams? params]) async {
    try {
      final res = await _permissionsService.openSettings();

      if (!res) return const Left(ServiceNotEnabledException());

      return const Right(null);
    } catch (e) {
      return Left(ServiceNotEnabledException(e.toString()));
    }
  }
}
