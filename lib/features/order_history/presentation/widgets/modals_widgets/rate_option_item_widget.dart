import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/order_history/domain/models/order_rate_option.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/order_rate_options_cubit/order_rate_options_cubit.dart';

class RateOptionItemWidget extends StatelessWidget {
  const RateOptionItemWidget({
    super.key,
    required this.option,
  });

  final OrderRateOption option;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OrderRateOptionsCubit>();

    return BlocBuilder<OrderRateOptionsCubit, OrderRateOptionsState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => cubit.selectOption(option.id),
          child: Container(
            margin: AppInsets.kAll4,
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
        );
      },
    );
  }
}
