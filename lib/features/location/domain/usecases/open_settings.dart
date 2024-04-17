import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';

@injectable
class OpenSettingsUseCase extends UseCase<void, NoParams> {
  OpenSettingsUseCase({
    required IPermissionsService permissionsService,
  }) : _permissionsService = permissionsService;

  final IPermissionsService _permissionsService;

  @override
  Future<Either<Failure, void>> call([NoParams? params]) async {
    final res = await _permissionsService.openSettings();
    if (!res) return const Left(ServiceNotEnabledException());
    return const Right(null);
  }
}
