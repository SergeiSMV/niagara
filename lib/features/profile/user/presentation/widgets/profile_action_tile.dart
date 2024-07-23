import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Виджет для отображения панели с действием на странице профиля
/// (e.g. выйти из аккаунта).
class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    required this.onTap,
    required this.leadingIcon,
    required this.title,
    this.notificationsCount,
  });

  final VoidCallback onTap;

  final SvgGenImage leadingIcon;

  final String title;

  final int? notificationsCount;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: leadingIcon.svg(
        width: AppSizes.kIconLarge,
        height: AppSizes.kIconLarge,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (notificationsCount != null && notificationsCount! > 0) ...[
            _StatusBadgeWidget(count: notificationsCount!),
            AppBoxes.kWidth8,
          ],
          Assets.icons.arrowRight.svg(
            width: AppSizes.kIconMedium,
            height: AppSizes.kIconMedium,
          ),
        ],
      ),
      title: Text(
        title,
        style: context.textStyle.textTypo.tx2Medium
            .withColor(context.colors.textColors.main),
      ),
      onTap: onTap,
    );
  }
}

/// Круглый бейджик для отображения числа непрочитанных извещений.
class _StatusBadgeWidget extends StatelessWidget {
  const _StatusBadgeWidget({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final String displayCount = count > 99 ? '99+' : count.toString();
    final captionTypo = context.textStyle.captionTypo;
    final TextStyle textStyle = count > 99 ? captionTypo.c2 : captionTypo.c1;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.infoColors.green,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        height: AppSizes.kGeneral20,
        width: AppSizes.kGeneral20,
        child: Center(
          child: Text(
            displayCount,
            style: textStyle.withColor(context.colors.textColors.white),
          ),
        ),
      ),
    );
  }
}
