import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll16 + AppInsets.kTop8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.orderPlacing.deliveryAddress,
                style: context.textStyle.textTypo.tx1SemiBold,
              ),
              InkWell(
                onTap: () {},
                child: Assets.icons.pen.svg(
                  width: AppSizes.kIconMedium,
                  height: AppSizes.kIconMedium,
                ),
              ),
            ],
          ),
          AppBoxes.kHeight8,
          Text(
            'улица имени Виктора Нарыкова, д. 50, кв. 23',
            style: context.textStyle.textTypo.tx2Medium,
          ),
        ],
      ),
    );
  }
}
