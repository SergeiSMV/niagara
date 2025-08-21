import 'package:auto_route/auto_route.dart';
import '../app_router.gr.dart';
import 'payment_routes.dart';

/// Класс роутера для карточки товара.
///
/// Инкапсулирует в себе все роуты, связанные с карточкой товара для удобства
/// навигации:
/// - [ProductRoute] - сама карточка товара;
/// - [PaymentRoutes] - роуты для оплат (нужны для предоплатной воды, оплата
/// которой происходит по сути внутри карточки товара).
abstract final class ProductRoutes {
  static AutoRoute get routes => AutoRoute(
        page: ProductRoute.page,
        children: [
          PaymentRoutes.routes,
        ],
      );
}
