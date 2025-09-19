import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../equipment/presentation/bloc/equipments_bloc/equipments_bloc.dart';
import '../../../new_products/presentation/bloc/new_products_bloc.dart';
import '../../../notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import '../../../order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import '../../../prepaid_water/presentation/bloc/balance_cubit/water_balance_cubit.dart';
import '../../../profile/bonuses/presentation/bloc/bonuses_bloc/bonuses_bloc.dart';
import '../../../promotions/presentation/cubit/promotions_cubit.dart';
import '../../../special_poducts/presentation/bloc/special_products_bloc.dart';
import '../../../stories/presentation/bloc/stories_bloc.dart';
import '../cubit/banners_cubit.dart';

/// Класс-обработчик обновления данных на главной странице
class HomePageRefreshHandler {
  /// Метод обновления главной страницы
  Future<void> onRefresh(BuildContext context) async {
    await Future.wait([
      _refreshNotifications(context),
      _refreshBonuses(context),
      _refreshPrepaidWater(context),
      _refreshBanners(context),
      _refreshEquipment(context),
      _refreshOrders(context),
      _refreshStories(context),
      _refreshPromotions(context),
      _refreshNewProducts(context),
      _refreshSpecialProducts(context),
    ]);
  }

  /// Обновляет уведомления
  static Future<void> _refreshNotifications(BuildContext context) async {
    context
        .read<NotificationsBloc>()
        .add(const NotificationsEvent.loading(isForceUpdate: true));
  }

  /// Обновляет бонусы
  static Future<void> _refreshBonuses(BuildContext context) async {
    context.read<BonusesBloc>().add(const BonusesEvent.started());
  }

  /// Обновляет баланс предоплатной воды
  static Future<void> _refreshPrepaidWater(BuildContext context) async {
    await context.read<WaterBalanceCubit>().getBottles();
  }

  /// Обновляет баннеры
  static Future<void> _refreshBanners(BuildContext context) async {
    await context.read<BannersCubit>().getBanners();
  }

  /// Обновляет оборудование
  static Future<void> _refreshEquipment(BuildContext context) async {
    context.read<EquipmentsBloc>().add(const EquipmentsEvent.getEquipments());
  }

  /// Обновляет заказы
  static Future<void> _refreshOrders(BuildContext context) async {
    context
        .read<OrdersBloc>()
        .add(const OrdersEvent.loading(isForceUpdate: true));
  }

  /// Обновляет истории
  static Future<void> _refreshStories(BuildContext context) async {
    context.read<StoriesBloc>().add(const StoriesEvent.load());
  }

  /// Обновляет промо
  static Future<void> _refreshPromotions(BuildContext context) async {
    context.read<PromotionsCubit>().refreshPromotions();
  }

  /// Обновляет новинки
  static Future<void> _refreshNewProducts(BuildContext context) async {
    context.read<NewProductsBloc>().add(const NewProductsEvent.loading());
  }

  /// Обновляет товары из категории "Специально для Вас"
  static Future<void> _refreshSpecialProducts(BuildContext context) async {
    context
        .read<SpecialProductsBloc>()
        .add(const SpecialProductsEvent.loading());
  }
}
