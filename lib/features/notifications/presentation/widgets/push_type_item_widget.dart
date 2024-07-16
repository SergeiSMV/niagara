import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';
import 'package:niagara_app/features/notifications/presentation/bloc/notifications_bloc/notifications_bloc.dart';

class PushTypeItemWidget extends StatelessWidget {
  const PushTypeItemWidget({
    super.key,
    required this.isSelected,
    required this.name,
  });

  final bool isSelected;
  final NotificationsTypes name;

  void _setSort(BuildContext context) {
    if (isSelected) return;
    context
        .read<NotificationsBloc>()
        .add(NotificationsEvent.setSort(sort: name));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal4,
      child: InkWell(
        onTap: () => _setSort(context),
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
              name.toLocale(),
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
