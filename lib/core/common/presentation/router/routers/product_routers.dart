import 'package:auto_route/auto_route.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/router/routers/payment_routers.dart';

/// Класс роутера для карточки товара.
///
/// Инкапсулирует в себе все роуты, связанные с карточкой товара для удобства
/// навигации:
/// - [ProductRoute] - сама карточка товара;
/// - [RecommendsRoute] - страница рекомендаций, которая может рекурсивно
/// открыть карточку товара;
/// - [PaymentRouters] - роуты для оплат (нужны для предоплатной воды, оплата
/// которой происходит по сути внутри карточки товара).
abstract final class ProductRouters {
  static AutoRoute get routers => AutoRoute(
        page: ProductRoute.page,
        children: [
          AutoRoute(page: RecommendsRoute.page),
          PaymentRouters.routers,
        ],
      );
}
