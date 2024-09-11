import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/payment_method_type.dart';
import 'package:niagara_app/features/order_placing/data/mappers/tokenization_data_mapper.dart';
import 'package:niagara_app/features/order_placing/domain/models/tokenization_data.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';
import 'package:niagara_app/features/vip/data/data_sources/vip_purchase_remote_data_source.dart';
import 'package:niagara_app/features/vip/data/dto/vip_order_info_dto.dart';
import 'package:niagara_app/features/vip/domain/repositories/vip_order_repository.dart';

@LazySingleton(as: IVipOrderRepository)
class VipOrderRepository extends BaseRepository implements IVipOrderRepository {
  const VipOrderRepository(
    super._logger,
    super._networkInfo,
    this._vipPurchaseRemoteDataSource,
  );

  final IVipOrderRemoteDataSource _vipPurchaseRemoteDataSource;

  @override
  Failure get failure => const VipOrderRepositoryFailure();

  @override
  Future<Either<Failure, TokenizationData>> createOrder({
    required PaymentMethod paymentMethod,
    required ActivationOption activationOption,
  }) =>
      execute(() async {
        final orderInfo = VipOrderInfoDto(
          paymentMethod: paymentMethod.toString(),
          monthsCount: int.parse(activationOption.count),
          sumRub: int.parse(activationOption.sum),
        );

        final result = await _vipPurchaseRemoteDataSource.createOrder(
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
