import 'package:niagara_app/core/common/domain/models/time_slot.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/data/mappers/delivery_time_options_mapper.dart';
import 'package:niagara_app/features/order_placing/data/mappers/tokenization_data_mapper.dart';
import 'package:niagara_app/features/order_placing/data/remote/data_sources/order_remote_data_source.dart';
import 'package:niagara_app/features/order_placing/data/remote/dto/order_placing_info_dto.dart';
import 'package:niagara_app/features/order_placing/domain/models/delivery_time_options.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/order_placing/domain/repositories/order_placing_repository.dart';

@LazySingleton(as: IOrderPlacingRepository)
class OrderPlacingRepository extends BaseRepository
    implements IOrderPlacingRepository {
  const OrderPlacingRepository(
    super._logger,
    super._networkInfo,
    this._orderPlacingRemoteDatasource,
  );

  final IOrderPlacingRemoteDataSource _orderPlacingRemoteDatasource;

  @override
  Failure get failure => const PlacingOrderRepositoryFailure();

  @override
  Future<Either<Failure, TokenizationData>> createOrder({
    required DateTime deliveryDate,
    required TimeSlot timeSlot,
    required PaymentMethod paymentMethod,
    String? comment,
  }) =>
      execute(() async {
        final orderInfo = OrderPlacingInfoDto(
          deliveryDate: deliveryDate.toIso8601String().split('.')[0],
          deliverySlotStart: '0001-01-01T${timeSlot.timeBegin}:00',
          deliverySlotEnd: '0001-01-01T${timeSlot.timeEnd}:00',
          paymentMethod: paymentMethod.toString(),
          description: comment ?? '',
        );

        final result = await _orderPlacingRemoteDatasource.createOrder(
          orderInfo: orderInfo,
        );

        return result.fold(
          (failure) => throw failure,
          (dto) => dto.status
              ? dto.tokenizationData.toModel()
              : throw const OrderNotCreatedFailure(),
        );
      });

  @override
  Future<Either<Failure, List<DeliveryTimeOptions>>> getDeliveryTimeOptions() =>
      execute(
        () => _orderPlacingRemoteDatasource.getDeliveryTimeOptions().fold(
              (failure) => throw failure,
              (dto) => dto.map((e) => e.toModel()).toList(),
            ),
      );
}
