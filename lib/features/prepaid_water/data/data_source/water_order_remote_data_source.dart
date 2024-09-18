import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_placing/data/remote/dto/order_draft_info_dto.dart';
import 'package:niagara_app/features/prepaid_water/data/dto/water_order_info_dto.dart';

abstract interface class IOrderWaterRemoteDataSource {
  /// Отправляет запрос на создание заказа на сервере. Принимает информацию о
  /// заказе [orderInfo].
  ///
  /// Возвращает информацию о созданном заказе, необходимую для запуска
  /// токенизации платежа в ЮКасса.
  Future<Either<Failure, OrderDraftInfoDto>> createOrder({
    required WaterOrderInfoDto orderInfo,
  });
}

@LazySingleton(as: IOrderWaterRemoteDataSource)
class OrderWaterRemoteDataSource implements IOrderWaterRemoteDataSource {
  OrderWaterRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, OrderDraftInfoDto>> createOrder({
    required WaterOrderInfoDto orderInfo,
  }) =>
      _requestHandler.sendRequest<OrderDraftInfoDto, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kOrderPrepaidWater,
          data: orderInfo.toJson(),
        ),
        converter: OrderDraftInfoDto.fromJson,
        failure: OrdersRemoteDataFailure.new,
      );
}
