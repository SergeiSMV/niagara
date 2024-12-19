import 'package:niagara_app/core/core.dart';

@injectable
class CheckGpsEnabledUseCase extends BaseUseCase<bool, NoParams> {
  CheckGpsEnabledUseCase(this._permissionsService);

  final IPermissionsService _permissionsService;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) async {
    final bool res = await _permissionsService.checkGeopositionEnabled();
    return Right(res);
  }
}
