import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';

/// Виджет для отображения панели с действием на странице профиля
/// (e.g. выйти из аккаунта).
class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    required this.onTap,
    required this.leadingIcon,
    required this.title,
  });

  final VoidCallback onTap;

  final SvgGenImage leadingIcon;

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon.svg(
        width: AppSizes.kIconLarge,
        height: AppSizes.kIconLarge,
      ),
      trailing: Assets.icons.arrowRight.svg(
        width: AppSizes.kIconMedium,
        height: AppSizes.kIconMedium,
      ),
      title: Text(
        title,
        style: context.textStyle.textTypo.tx2Medium,
      ),
      onTap: onTap,
    );
  }
}
