import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../domain/models/order_rate_option.dart';
import '../../bloc/order_rate_options_cubit/order_rate_options_cubit.dart';

class RateOptionItemWidget extends StatelessWidget {
  const RateOptionItemWidget({
    required this.option,
    super.key,
  });

  final OrderRateOption option;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderRateOptionsCubit>();

    return BlocBuilder<OrderRateOptionsCubit, OrderRateOptionsState>(
      builder: (context, state) => InkWell(
        onTap: () => cubit.selectOption(option.id),
        child: Container(
          margin: AppInsets.kVertical4 + AppInsets.kRight8,
          padding: AppInsets.kHorizontal12 + AppInsets.kVertical8,
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular6,
            color: option.isSelected
                ? context.colors.buttonColors.primary
                : context.colors.mainColors.bgCard,
          ),
          child: Text(
            option.name,
            style: context.textStyle.textTypo.tx2Medium.withColor(
              option.isSelected
                  ? context.colors.textColors.white
                  : context.colors.textColors.main,
            ),
          ),
        ),
      ),
    );
  }
}
