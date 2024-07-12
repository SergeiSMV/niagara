import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      padding: AppInsets.kAll8,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular12,
        color: context.colors.mainColors.bgCard,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppBorders.kCircular6,
            child: ExtendedImage.network(
              '', //product.imageUrl,
              fit: BoxFit.fitHeight,
              loadStateChanged: (state) =>
                  state.extendedImageLoadState == LoadState.loading
                      ? const AppCenterLoader()
                      : null,
            ),
          ),
          AppBoxes.kWidth12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Питьевая вода Niagara Premium газированная',
                  style: context.textStyle.textTypo.tx2Medium,
                ),
                AppBoxes.kHeight6,
                Text(
                  '1,45 л. / 6 шт. ',
                  style: context.textStyle.descriptionTypo.des3
                      .withColor(context.colors.textColors.secondary),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '200 ₽',
                      style: context.textStyle.textTypo.tx1SemiBold,
                    ),
                    Text(
                      '1 шт.',
                      style: context.textStyle.textTypo.tx2Medium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
