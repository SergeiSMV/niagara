import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key, required this.address});

  /// Адрес доставки.
  final String address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll16 + AppInsets.kTop8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.orderPlacing.deliveryAddress,
            style: context.textStyle.textTypo.tx1SemiBold,
          ),
          AppBoxes.kHeight8,
          Text(
            address,
            style: context.textStyle.textTypo.tx2Medium,
          ),
        ],
      ),
    );
  }
}
