import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/cart/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:niagara_app/features/cart/favorites/presentation/widgets/go_shopping_button.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  void _clearFavorites(BuildContext context) => context
    ..read<FavoritesBloc>().add(const FavoritesEvent.removeAllFavorites())
    ..maybePop();

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: AppInsets.kAll8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.mainColors.white,
              borderRadius: BorderRadius.circular(
                AppSizes.kGeneral24 - AppSizes.kGeneral4,
              ),
            ),
            child: Padding(
              padding: AppInsets.kVertical24 + AppInsets.kHorizontal16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.favorites.clearTitle,
                    style: context.textStyle.headingTypo.h3
                        .withColor(context.colors.textColors.main),
                  ),
                  AppBoxes.kHeight8,
                  Text(
                    t.favorites.clearDescription,
                    style: context.textStyle.textTypo.tx1Medium
                        .withColor(context.colors.textColors.secondary),
                    textAlign: TextAlign.center,
                  ),
                  AppBoxes.kHeight24,
                  Material(
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextButton.secondary(
                            text: t.common.cancel,
                            onTap: () => context.maybePop(),
                          ),
                        ),
                        AppBoxes.kWidth12,
                        Expanded(
                          child: AppTextButton.primary(
                            text: t.common.delete,
                            onTap: () => _clearFavorites(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          buildWhen: (previous, current) => previous != current,
          builder: (ctx, state) => state.maybeWhen(
            loading: AppCenterLoader.new,
            loaded: (products) {
              if (products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      Column(
                        children: [
                          Assets.images.bell.image(
                            width: 170,
                            height: 170,
                          ),
                          AppBoxes.kHeight16,
                          Text(
                            t.favorites.empty,
                            style: context.textStyle.headingTypo.h3
                                .withColor(context.colors.textColors.main),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const Spacer(),
                      const GoShoppingButton(),
                    ],
                  ),
                );
              }
              return Padding(
                padding: AppInsets.kHorizontal16 +
                    AppInsets.kVertical12 +
                    AppInsets.kTop48,
                child: Column(
                  children: [
                    AppBoxes.kHeight16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.favorites.product(n: products.length),
                          style: context.textStyle.textTypo.tx2Medium.withColor(
                            context.colors.textColors.main,
                          ),
                        ),
                        InkWell(
                          onTap: () => _showDeleteDialog(context),
                          child: Text(
                            t.favorites.clear,
                            style:
                                context.textStyle.textTypo.tx2Medium.withColor(
                              context.colors.infoColors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: AppInsets.kVertical12,
                        child: GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          mainAxisSpacing: AppSizes.kGeneral8,
                          crossAxisSpacing: AppSizes.kGeneral8,
                          childAspectRatio:
                              context.screenWidth / context.screenHeight / .8,
                          padding: AppInsets.kAll1,
                          children: List.generate(
                            products.length,
                            (index) => ProductWidget(
                              product: products[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible: hasMore,
                    //   child: Padding(
                    //     padding: AppInsets.kAll16,
                    //     child: Center(
                    //       child: Assets.lottie.loadCircle.lottie(
                    //         width: AppSizes.kLoaderBig,
                    //         height: AppSizes.kLoaderBig,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
