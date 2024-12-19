import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/settings_type.dart';

@injectable
class OpenSettingsUseCase extends BaseUseCase<void, SettingsType> {
  OpenSettingsUseCase(this._permissionsService);

  final IPermissionsService _permissionsService;

  @override
  Future<Either<Failure, void>> call(SettingsType type) async {
    final res = await (type == SettingsType.location
        ? _permissionsService.openLocationSettings()
        : _permissionsService.openSettings());
    if (!res) return const Left(ServiceNotEnabledException());
    return const Right(null);
  }
}
