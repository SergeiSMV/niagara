import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/equipment/domain/repositories/equipments_repository.dart';

@injectable
class OrderCleaningUseCase extends BaseUseCase<bool, OrderCleaningParams> {
  const OrderCleaningUseCase(this._equipmentsRepository);

  final IEquipmentsRepository _equipmentsRepository;

  @override
  Future<Either<Failure, bool>> call(
    OrderCleaningParams params,
  ) async =>
      _equipmentsRepository.orderCleaning(
        date: params.date,
        locationId: params.locationId,
        deviceId: params.deviceId,
        timeBegin: params.timeBegin,
        timeEnd: params.timeEnd,
        comment: params.comment,
      );
}

class OrderCleaningParams extends Equatable {
  const OrderCleaningParams({
    required this.date,
    required this.locationId,
    required this.deviceId,
    required this.timeBegin,
    required this.timeEnd,
    required this.comment,
  });

  final String date;
  final String locationId;
  final int deviceId;
  final String timeBegin;
  final String timeEnd;
  final String comment;

  @override
  List<Object?> get props => [
        date,
        locationId,
        deviceId,
        timeBegin,
        timeEnd,
        comment,
      ];
}
