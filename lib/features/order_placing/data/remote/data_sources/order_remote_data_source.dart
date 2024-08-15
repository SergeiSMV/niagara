import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/order_placing/data/remote/dto/delivery_time_options_dto.dart';
import 'package:niagara_app/features/order_placing/data/remote/dto/order_draft_info_dto.dart';
import 'package:niagara_app/features/order_placing/data/remote/dto/order_placing_info_dto.dart';

/// Источник данных с сервера для оформления заказа и получения доступных дат
/// доставки.
abstract interface class IOrderPlacingRemoteDataSource {
  /// Отправляет запрос на получение списка доступных дат и временных интервалов
  /// доставки в рамках каждой даты для локации с заданым [locationId].
  Future<Either<Failure, List<DeliveryTimeOptionsDto>>> getDeliveryTimeOptions({
    required String locationId,
  });

  /// Отправляет запрос на создание заказа на сервере. Принимает информацию о
  /// заказе [orderInfo].
  ///
  /// Возвращает информацию о созданном заказе, необходимую для запуска
  /// токенизации платежа в ЮКасса.
  Future<Either<Failure, OrderDraftInfoDto>> createOrder({
    required OrderPlacingInfoDto orderInfo,
  });
}

@LazySingleton(as: IOrderPlacingRemoteDataSource)
class OrderPlacingRemoteDataSource implements IOrderPlacingRemoteDataSource {
  OrderPlacingRemoteDataSource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, List<DeliveryTimeOptionsDto>>> getDeliveryTimeOptions({
    required String locationId,
  }) =>
      _requestHandler.sendRequest<List<DeliveryTimeOptionsDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetDeliveryTimeOptions,
          queryParameters: {'location': locationId},
        ),
        converter: (json) => json
            .map((e) => e as Map<String, dynamic>)
            .map(DeliveryTimeOptionsDto.fromJson)
            .toList(),
        failure: OrdersRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, OrderDraftInfoDto>> createOrder({
    required OrderPlacingInfoDto orderInfo,
  }) =>
      _requestHandler.sendRequest<OrderDraftInfoDto, Map<String, dynamic>>(
        request: (dio) => dio.post(
          ApiConst.kCreateOrder,
          data: orderInfo.toJson(),
        ),
        converter: OrderDraftInfoDto.fromJson,
        failure: OrdersRemoteDataFailure.new,
      );
}
