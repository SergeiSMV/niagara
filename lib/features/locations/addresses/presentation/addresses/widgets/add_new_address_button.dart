import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class AddNewAddressButton extends StatelessWidget {
  const AddNewAddressButton({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => context.pushRoute(const ChoiceOnMapRoute()),
        child: Padding(
          padding: AppInsets.kSymmetricH16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: AppInsets.kSymmetricV12,
                child: Text(
                  t.locations.addNewAddress,
                  style: context.textStyle.textTypo.tx1Medium
                      .withColor(context.colors.textColors.main),
                ),
              ),
              Assets.icons.add.svg(
                width: AppSizes.kIconLarge,
                height: AppSizes.kIconLarge,
              ),
            ],
          ),
        ),
      );
}
