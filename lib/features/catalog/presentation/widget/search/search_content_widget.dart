import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_widget.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class SearchContentWidget extends StatelessWidget {
  const SearchContentWidget({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (products.isNotEmpty)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: AppSizes.kGeneral8,
              crossAxisSpacing: AppSizes.kGeneral8,
              childAspectRatio: context.screenWidth / context.screenHeight / .8,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                products.length,
                (index) => ProductWidget(
                  product: products[index],
                ),
              ),
            )
          else
            const _EmptyContentWidget(),
        ],
      ),
    );
  }
}

class _EmptyContentWidget extends StatelessWidget {
  const _EmptyContentWidget();

  @override
  Widget build(BuildContext context) {
    final textColors = context.colors.textColors;
    final textStyle = context.textStyle;

    return Padding(
      padding: AppInsets.kAll16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: AppInsets.kHorizontal64,
            child: Assets.images.search3D.image(),
          ),
          AppBoxes.kHeight16,
          Text(
            t.catalog.nothingWasFound,
            style: textStyle.headingTypo.h3.withColor(textColors.main),
            textAlign: TextAlign.center,
          ),
          AppBoxes.kHeight8,
          Text(
            t.catalog.changingQueryOrGoToCatalog,
            style: textStyle.textTypo.tx3Medium.withColor(textColors.secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
