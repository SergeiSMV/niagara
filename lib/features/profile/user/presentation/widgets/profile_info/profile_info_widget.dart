import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/order_status.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/profile_action_tile.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/profile_actions_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
                      loaded: (orders) => orders
                          .where(
                            (o) =>
                                o.orderStatus == OrderStatus.goingTo ||
                                o.orderStatus == OrderStatus.onWay,
                          )
                          .length,
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
                ),
                ProfileActionTile(
                  leadingIcon: Assets.icons.mapPoint,
                  title: t.profile.profileInfo.deliveryAddresses,
                  // onTap: () => PaymentsRepository().confirmPayment(
                  //   'confirmPayment',
                  //   null,
                  // ),
                ),
                ProfileActionTile(
                  leadingIcon: Assets.icons.card,
                  title: t.profile.profileInfo.paymentMethods,
                  // onTap: () {
                  //   final repo = PaymentsRepository();
                  //   repo.startTokenaztion();
                  // },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
