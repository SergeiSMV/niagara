import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/order_rate_options_cubit/order_rate_options_cubit.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/rate_option_item_widget.dart';

class ListOptionsWidget extends StatelessWidget {
  const ListOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderRateOptionsCubit, OrderRateOptionsState>(
      builder: (context, state) {
        final rating = context.read<OrderRateOptionsCubit>().rating;
        return state.when(
          loading: () => const SizedBox(
            height: AppSizes.kGeneral64,
            child: AppCenterLoader(),
          ),
          loaded: (options) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rating == 5.0
                      ? t.recentOrders.whatWouldYouLikeToImprove
                      : t.recentOrders.heading,
                  style: context.textStyle.textTypo.tx1SemiBold
                      .withColor(context.colors.textColors.main),
                ),
                AppBoxes.kHeight12,
                Wrap(
                  children: options
                      .map((e) => RateOptionItemWidget(option: e))
                      .toList(),
                ),
                AppBoxes.kHeight24,
              ],
            );
          },
          error: () => const SizedBox.shrink(),
          empty: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
