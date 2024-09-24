import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/promotions/presentation/cubit/promotions_cubit.dart';
import 'package:niagara_app/features/promotions/presentation/widgets/promotion_widget.dart';

@RoutePage()
class PromotionsPage extends StatelessWidget {
  const PromotionsPage({
    super.key,
    required this.isPersonal,
  });

  final bool isPersonal;

  void _loadMore(BuildContext context) =>
      context.read<PromotionsCubit>().getMorePromotions();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: getIt<PromotionsCubit>(param1: isPersonal),
        child: BlocBuilder<PromotionsCubit, PromotionsState>(
          builder: (ctx, state) {
            final hasMore = ctx.read<PromotionsCubit>().hasMore;
            return state.maybeWhen(
              orElse: SizedBox.shrink,
              loading: () => const AppCenterLoader(),
              loaded: (promotions) => NotificationListener(
                onNotification: (ScrollEndNotification notification) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent /
                          AppSizes.kGeneral2) {
                    _loadMore(ctx);
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppBoxes.kHeight48,
                      ...List.generate(
                        promotions.length,
                        (index) => Padding(
                          padding: AppInsets.kVertical12,
                          child: PromotionWidget(
                            promotion: promotions[index],
                            withTitle: true,
                          ),
                        ),
                      ),
                      if (hasMore)
                        Assets.lottie.loadCircle.lottie(
                          width: AppSizes.kGeneral64,
                          height: AppSizes.kGeneral64,
                          repeat: true,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
