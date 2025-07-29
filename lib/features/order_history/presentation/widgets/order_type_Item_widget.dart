import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/enums/orders_types.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../bloc/orders_bloc/orders_bloc.dart';

class OrderTypeItemWidget extends StatelessWidget {
  const OrderTypeItemWidget({
    required this.isSelected,
    required this.name,
    super.key,
  });

  final bool isSelected;
  final OrdersTypes name;

  void _setSort(BuildContext context) {
    if (isSelected) return;
    context.read<OrdersBloc>().add(OrdersEvent.setSort(sort: name));
  }

  @override
  Widget build(BuildContext context) => Padding(
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
