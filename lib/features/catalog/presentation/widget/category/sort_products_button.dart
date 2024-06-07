import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/products_sort_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';

class SortProductsButton extends StatelessWidget {
  const SortProductsButton({
    super.key,
  });

  Future<void> _onSetSort(BuildContext context, ProductsSortType sort) async =>
      context.read<ProductsBloc>().add(ProductsEvent.setSort(sort: sort));

  Future<void> _onCloseModal(BuildContext context) async => context.maybePop();

  Future<void> _showSortModal(BuildContext context) async =>
      showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: context.colors.mainColors.white,
        useSafeArea: true,
        builder: (ctx) => Padding(
          padding: AppInsets.kHorizontal16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PinWidget(),
              AppBoxes.kHeight12,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.catalog.sorting,
                    style: context.textStyle.textTypo.tx1SemiBold
                        .withColor(context.colors.textColors.main),
                  ),
                  CloseModalButton(onTap: () => _onCloseModal(ctx)),
                ],
              ),
              AppBoxes.kHeight8,
              ...List.generate(
                ProductsSortType.values.length,
                (index) {
                  final sortType = ProductsSortType.values[index];
                  final selectedType = context.read<ProductsBloc>().sort;
                  final isSelected = selectedType == sortType;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          _onSetSort(context, sortType);
                          _onCloseModal(ctx);
                        },
                        child: Padding(
                          padding: AppInsets.kVertical16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                sortType.toLocale(),
                                style: context.textStyle.textTypo.tx2SemiBold
                                    .withColor(context.colors.textColors.main),
                              ),
                              if (isSelected)
                                Assets.icons.check.svg(
                                  width: AppSizes.kIconMedium,
                                  height: AppSizes.kIconMedium,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        height: AppSizes.kGeneral2,
                        thickness: AppSizes.kGeneral1,
                        color: context.colors.otherColors.separator30,
                      ),
                    ],
                  );
                },
              ),
              AppBoxes.kHeight48,
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => _showSortModal(context),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppBorders.kCircular8,
            color: context.colors.mainColors.bgCard,
          ),
          child: Padding(
            padding: AppInsets.kHorizontal24 + AppInsets.kVertical12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.icons.sorting.svg(
                  width: AppSizes.kIconMedium,
                  height: AppSizes.kIconMedium,
                ),
                AppBoxes.kWidth8,
                Text(
                  t.catalog.sort,
                  style: context.textStyle.buttonTypo.btn2semiBold
                      .withColor(context.colors.textColors.accent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
