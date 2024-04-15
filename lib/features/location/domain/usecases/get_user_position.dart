import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class LocationPermissionUseCase extends UseCase<PermissionStatus, NoParams> {
  LocationPermissionUseCase({
    required IPermissionsService permissionsService,
  }) : _permissionsService = permissionsService;

  final IPermissionsService _permissionsService;

  @override
  Future<Either<Failure, PermissionStatus>> call([NoParams? params]) async {
    try {
      final res = await _permissionsService.checkLocationPermission();
      if (!res.isGranted) {
        return const Left(LocationDataFailure());
      }

      return Right(res);
    } catch (e) {
      return Left(LocationDataFailure(e.toString()));
    }
  }
}
