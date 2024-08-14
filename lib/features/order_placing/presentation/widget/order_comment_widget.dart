import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class OrderCommentWidget extends StatelessWidget {
  const OrderCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kAll16 + AppInsets.kTop8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.orderPlacing.comment,
            style: context.textStyle.textTypo.tx1SemiBold
                .withColor(context.colors.textColors.main),
          ),
          AppBoxes.kHeight12,
          AppTextField.text(
            expandable: true,
            label: t.orderPlacing.informationForTheDriver,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
