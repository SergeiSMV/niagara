import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/data/mappers/tokenization_data_mapper.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/prepaid_water/data/data_source/water_order_remote_data_source.dart';
import 'package:niagara_app/features/prepaid_water/data/dto/water_order_info_dto.dart';
import 'package:niagara_app/features/prepaid_water/domain/model/prepaid_water_order_data.dart';
import 'package:niagara_app/features/prepaid_water/domain/repository/order_water_repository.dart';

@LazySingleton(as: IOrderWaterRepository)
class OrderWaterRepository extends BaseRepository
    implements IOrderWaterRepository {
  const OrderWaterRepository(
    super._logger,
    super._networkInfo,
    this._orderWaterRemoteDataSource,
  );

  final IOrderWaterRemoteDataSource _orderWaterRemoteDataSource;

  @override
  Failure get failure => OrderWaterRepositoryFailure();

  @override
  Future<Either<Failure, TokenizationData>> createOrder({
    required PaymentMethod paymentMethod,
    required OrderWaterData orderData,
  }) =>
      execute(() async {
        final orderInfo = WaterOrderInfoDto(
          paymentMethod: paymentMethod.toString(),
          count: orderData.count,
          productId: orderData.productId,
        );

        final result = await _orderWaterRemoteDataSource.createOrder(
          orderInfo: orderInfo,
        );

        return result.fold(
          (failure) => throw failure,
          (dto) => dto.status
              ? dto.tokenizationData.toModel()
              : throw const OrderNotCreatedFailure(),
        );
      });
}
