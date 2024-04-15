import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';

@injectable
class LocationPermissionUseCase extends UseCase<bool, NoParams> {
  LocationPermissionUseCase({
    required PermissionsService permissionsService,
  }) : _permissionsService = permissionsService;

  final PermissionsService _permissionsService;

  @override
  Future<Either<Failure, bool>> call([NoParams? params]) async {
    try {
      final isGranted = await _permissionsService.checkLocationPermission();
      if (!isGranted) return const Left(LocationDataFailure());

      return Right(isGranted);
    } catch (e) {
      return Left(LocationDataFailure(e.toString()));
    }
  }
}
