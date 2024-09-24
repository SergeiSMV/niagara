import 'package:niagara_app/core/core.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class NotificationsPermissionUseCase
    extends BaseUseCase<PermissionStatus, NoParams> {
  NotificationsPermissionUseCase(this._permissionsService);

  final IPermissionsService _permissionsService;

  @override
  Future<Either<Failure, PermissionStatus>> call([NoParams? params]) async {
    final res = await _permissionsService.checkNotificationPermission();
    if (!res.isGranted) return const Left(LocationDataFailure());
    return Right(res);
  }
}
