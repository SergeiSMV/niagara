import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';

class GroupButton extends StatelessWidget {
  const GroupButton({
    super.key,
    required this.group,
    required this.isSelected,
    this.onTap,
  });

  final Group group;
  final bool isSelected;
  final VoidCallback? onTap;

  void _navigateToGroup(
    BuildContext context, {
    required Group group,
  }) =>
      context.navigateTo(
        CatalogWrapper(
          children: [
            const CatalogRoute(),
            CategoryWrapperRoute(
              group: group,
              children: const [CategoryRoute()],
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal4,
      child: InkWell(
        onTap: isSelected
            ? null
            : onTap ??
                () => _navigateToGroup(
                      context,
                      group: group,
                    ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular6,
            color: isSelected
                ? context.colors.buttonColors.primary
                : context.colors.mainColors.bgCard,
          ),
          child: Padding(
            padding: AppInsets.kHorizontal12 + AppInsets.kVertical8,
            child: Text(
              group.name,
              style: context.textStyle.textTypo.tx2Medium.withColor(
                isSelected
                    ? context.colors.mainColors.white
                    : context.colors.textColors.main,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
