import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/go_shopping_button.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
}
