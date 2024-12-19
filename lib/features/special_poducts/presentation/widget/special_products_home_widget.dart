import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/special_poducts/presentation/bloc/special_products_bloc.dart';

/// Виджет, отображающий горизонтальный список с товарами из категории
/// "Специально для Вас".
class SpecialProductsHomeWidget extends StatelessWidget {
  const SpecialProductsHomeWidget({super.key});

  /// Преобразует [Product] в [ProductWidget].
  Widget _toWidget(Product product) => ProductWidget(product: product);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialProductsBloc, SpecialProductsState>(
      builder: (_, state) => state.map(
        loading: (_) => const SizedBox.shrink(),
        error: (_) => const SizedBox.shrink(),
        loaded: (state) {
          // Если товаров нет, виджет не отображается.
          if (state.totalItems == 0) {
            return const SizedBox.shrink();
          }

          final List<Widget> children = state.products.map(_toWidget).toList();

          // Если идёт загрузка, добавляем ещё один элемент под индикатор
          // загрузки.
          final int length =
              state.loadingMore ? children.length + 1 : children.length;

          return SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.colors.mainColors.white,
                borderRadius: AppBorders.kCircular16 + AppBorders.kCircular2,
              ),
              child: Padding(
                padding: AppInsets.kVertical16 + AppInsets.kTop32,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: AppInsets.kHorizontal16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t.specialProducts.specialProducts,
                            style: context.textStyle.headingTypo.h3.withColor(
                              context.colors.textColors.main,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppBoxes.kHeight12,
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: ListView.separated(
                        itemCount: length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        padding: AppInsets.kHorizontal16,
                        itemBuilder: (_, index) {
                          if (index == length - 1 && state.loadingMore) {
                            return Center(
                              child: Padding(
                                padding: AppInsets.kVertical16 +
                                    AppInsets.kHorizontal32 +
                                    AppInsets.kBottom16,
                                child: Assets.lottie.loadCircle.lottie(
                                  width: AppSizes.kGeneral64,
                                  height: AppSizes.kGeneral64,
                                  repeat: true,
                                ),
                              ),
                            );
                          }

                          // Если дошли до предпоследнего элемента, загружаем
                          // ещё порцию.
                          if (index == children.length - 3) {
                            context.read<SpecialProductsBloc>().add(
                                  const SpecialProductsEvent.loadMore(),
                                );
                          }

                          return AspectRatio(
                            aspectRatio: .55,
                            child: children[index],
                          );
                        },
                        separatorBuilder: (_, __) => AppBoxes.kWidth8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
