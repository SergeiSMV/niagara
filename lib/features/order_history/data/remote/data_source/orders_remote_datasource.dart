import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/orders_types.dart';
import 'package:niagara_app/features/order_history/data/remote/dto/user_order_dto.dart';

abstract interface class IOrdersRemoteDatasource {
  Future<Either<Failure, OrdersDto>> getOrders({
    required int page,
    required OrdersTypes sort,
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
            'sort': sort.name,
          }, //OrderDto
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
}
