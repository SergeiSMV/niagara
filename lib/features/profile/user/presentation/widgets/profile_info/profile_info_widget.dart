import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../../core/utils/constants/app_borders.dart';
import '../../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../../core/utils/constants/app_insets.dart';
import '../../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../../core/utils/gen/assets.gen.dart';
import '../../../../../../core/utils/gen/strings.g.dart';
import '../../../../../notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import '../../../../../order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import '../profile_action_tile.dart';
import '../profile_actions_widget.dart';

/// Виджет для отображения разделов пользователя "Мои данные"
/// включает в себя:
/// - Уведомления [NotificationsRoute]
/// - История заказов [OrdersRoute]
/// - Мое оборудование [EquipmentsRoute]
/// - Предоплаченная вода [PrepaidWaterRoute]
/// - Адреса доставки [LocationsWrapper]
///
class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          borderRadius: AppBorders.kCircular18,
        ),
        child: Padding(
          padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBoxes.kHeight4,
              Text(
                t.profile.profileInfo.profileInfoHeader,
                style: context.textStyle.textTypo.tx1SemiBold,
              ),
              AppBoxes.kHeight8,
              ProfileActionsWidget(
                children: [
                  BlocBuilder<NotificationsBloc, NotificationsState>(
                    builder: (_, state) => ProfileActionTile(
                      leadingIcon: Assets.icons.notifications,
                      title: t.profile.profileInfo.notifications,
                      notificationsCount: state.maybeWhen(
                        loaded: (_, notifications, __) =>
                            notifications.where((n) => n.isNew).length,
                        orElse: () => 0,
                      ),
                      redirectRoute: const NotificationsRoute(),
                    ),
                  ),
                  BlocBuilder<OrdersBloc, OrdersState>(
                    builder: (_, state) => ProfileActionTile(
                      leadingIcon: Assets.icons.boxOrder,
                      title: t.profile.profileInfo.orderHistory,
                      notificationsCount: state.maybeWhen(
                        loaded: (orders, _) =>
                            orders.where((o) => o.isActive).length,
                        orElse: () => 0,
                      ),
                      redirectRoute: const OrdersRoute(),
                    ),
                  ),
                  ProfileActionTile(
                    leadingIcon: Assets.icons.purifier,
                    title: t.profile.profileInfo.equipment,
                    redirectRoute: const EquipmentsRoute(),
                  ),
                  ProfileActionTile(
                    leadingIcon: Assets.icons.water,
                    title: t.profile.profileInfo.prepaidWater,
                    redirectRoute: const PrepaidWaterRoute(),
                  ),
                  ProfileActionTile(
                    leadingIcon: Assets.icons.mapPoint,
                    title: t.profile.profileInfo.deliveryAddresses,
                    redirectRoute: const LocationsWrapper(
                      children: [
                        LocationsTabRoute(children: [AddressesRoute()]),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
