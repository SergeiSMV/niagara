import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_placing/data/remote/dto/order_draft_info_dto.dart';
import 'package:niagara_app/features/vip/data/dto/vip_order_info_dto.dart';

abstract interface class IVipOrderRemoteDataSource {
  /// Отправляет запрос на создание заказа на сервере. Принимает информацию о
  /// заказе [orderInfo].
  ///
  /// Возвращает информацию о созданном заказе, необходимую для запуска
  /// токенизации платежа в ЮКасса.
  Future<Either<Failure, OrderDraftInfoDto>> createOrder({
    required VipOrderInfoDto orderInfo,
  });
}

@LazySingleton(as: IVipOrderRemoteDataSource)
class VipOrderRemoteDataSource implements IVipOrderRemoteDataSource {
  VipOrderRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, OrderDraftInfoDto>> createOrder({
    required VipOrderInfoDto orderInfo,
  }) =>
      _requestHandler.sendRequest<OrderDraftInfoDto, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kOrderVip,
          data: orderInfo.toJson(),
        ),
        converter: OrderDraftInfoDto.fromJson,
        failure: OrdersRemoteDataFailure.new,
      );
}
