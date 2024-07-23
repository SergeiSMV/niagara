import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
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
                ProfileActionTile(
                  leadingIcon: Assets.icons.boxOrder,
                  title: t.profile.profileInfo.orderHistory,
                  notificationsCount: 10,
                  onTap: () {},
                ),
                ProfileActionTile(
                  leadingIcon: Assets.icons.purifier,
                  title: t.profile.profileInfo.equipment,
                  onTap: () {},
                ),
                ProfileActionTile(
                  leadingIcon: Assets.icons.water,
                  title: t.profile.profileInfo.prepaidWater,
                  onTap: () {},
                ),
                ProfileActionTile(
                  leadingIcon: Assets.icons.mapPoint,
                  title: t.profile.profileInfo.deliveryAddresses,
                  onTap: () {},
                ),
                ProfileActionTile(
                  leadingIcon: Assets.icons.card,
                  title: t.profile.profileInfo.paymentMethods,
                  onTap: () {},
                ),
                ProfileActionTile(
                  leadingIcon: Assets.icons.notifications,
                  title: t.profile.profileInfo.notifications,
                  notificationsCount: 100,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
