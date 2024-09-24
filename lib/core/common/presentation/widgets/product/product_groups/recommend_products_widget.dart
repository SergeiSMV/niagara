import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_widget.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/recommends_cubit/recommends_cubit.dart';

class RecommendProductsWidget extends StatelessWidget {
  const RecommendProductsWidget({
    super.key,
    required Product product,
  }) : _product = product;

  final Product _product;

  void _navigateToAllRecommendations(
    BuildContext context,
    List<Product> products,
  ) =>
      context.navigateTo(RecommendsRoute(products: products));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RecommendsCubit>(param1: _product),
      child: BlocBuilder<RecommendsCubit, RecommendsState>(
        builder: (_, state) => state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => Assets.lottie.loadCircle.lottie(
            width: AppSizes.kLoaderSmall,
            height: AppSizes.kLoaderSmall,
            repeat: true,
          ),
          loaded: (products) => products.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.colors.mainColors.white,
                      borderRadius:
                          AppBorders.kCircular16 + AppBorders.kCircular2,
                    ),
                    child: Padding(
                      padding: AppInsets.kVertical16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: AppInsets.kHorizontal16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  t.catalog.recommendedViewing,
                                  style: context.textStyle.textTypo.tx1SemiBold
                                      .withColor(
                                    context.colors.textColors.main,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => _navigateToAllRecommendations(
                                    context,
                                    products,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        t.common.all,
                                        style: context
                                            .textStyle.buttonTypo.btn3semiBold
                                            .withColor(
                                          context.colors.textColors.accent,
                                        ),
                                      ),
                                      Assets.icons.arrowRight.svg(
                                        width: AppSizes.kIconSmall,
                                        height: AppSizes.kIconSmall,
                                        colorFilter: ColorFilter.mode(
                                          context.colors.textColors.accent,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppBoxes.kHeight12,
                          AspectRatio(
                            aspectRatio: 1.2,
                            child: ListView.separated(
                              itemCount: products.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: AppInsets.kHorizontal16,
                              itemBuilder: (_, index) => AspectRatio(
                                aspectRatio: .5,
                                child: ProductWidget(product: products[index]),
                              ),
                              separatorBuilder: (_, __) => AppBoxes.kWidth8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
