import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/model/equipment.dart';

abstract interface class IEquipmentsRepository {
  Future<Either<Failure, List<Equipment>>> getEquipments();
}
