import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/features/order_history/data/remote/dto/order_rate_option_dto.dart';
import 'package:niagara_app/features/order_history/data/remote/dto/user_order_dto.dart';

abstract interface class IOrdersRemoteDatasource {
  Future<Either<Failure, OrdersDto>> getOrders({
    required int page,
    required OrdersTypes sort,
  });

  Future<Either<Failure, List<OrderRateOptionDto>>> getOrderRateOptions({
    required int rating,
  });

  Future<Either<Failure, bool>> rateOrder({
    required String id,
    required int rating,
    required String comment,
    required List<String> optionsIds,
  });
}

@LazySingleton(as: IOrdersRemoteDatasource)
class OrdersRemoteDatasource implements IOrdersRemoteDatasource {
  OrdersRemoteDatasource(this._requestHandler);

  final RequestHandler _requestHandler;

  @override
  Future<Either<Failure, OrdersDto>> getOrders({
    required int page,
    required OrdersTypes sort,
  }) =>
      _requestHandler.sendRequest<OrdersDto, Map<String, dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetOrders,
          queryParameters: {
            'page': page,
            'status': sort.name,
          },
        ),
        converter: (json) {
          final orders = (json['data'] as List<dynamic>)
              .map((e) => UserOrderDto.fromJson(e as Map<String, dynamic>))
              .toList();

          final pagination = PaginationDto.fromJson(
            json['pagination'] as Map<String, dynamic>,
          );

          return (orders: orders, pagination: pagination);
        },
        failure: OrdersRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, List<OrderRateOptionDto>>> getOrderRateOptions({
    required int rating,
  }) =>
      _requestHandler.sendRequest<List<OrderRateOptionDto>, List<dynamic>>(
        request: (dio) => dio.get(
          ApiConst.kGetOrderRating,
          queryParameters: {
            'rating': rating,
          },
        ),
        converter: (json) => json
            .map(
              (e) => OrderRateOptionDto.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
        failure: OrdersRemoteDataFailure.new,
      );

  @override
  Future<Either<Failure, bool>> rateOrder({
    required String id,
    required int rating,
    required String comment,
    required List<String> optionsIds,
  }) =>
      _requestHandler.sendRequest<bool, bool>(
        request: (dio) => dio.post(
          ApiConst.kEvaluateOrder,
          data: {
            'ORDER_ID': id,
            'ORDER_VALUE': rating,
            'ORDER_DESCRIPTION': comment,
            'ORDER_PARAM': optionsIds,
          },
        ),
        converter: (result) => result,
        failure: OrdersRemoteDataFailure.new,
      );
}
