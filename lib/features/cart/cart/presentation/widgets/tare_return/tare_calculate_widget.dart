import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_borders.dart';
import '../../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../../core/utils/constants/app_insets.dart';
import '../../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../../core/utils/gen/assets.gen.dart';
import '../../../../../../core/utils/gen/strings.g.dart';

/// Виджет общей суммы тары
class TareCalculateWidget extends StatelessWidget {
  const TareCalculateWidget({
    required this.tareSum,
    required this.taraProductInfo,
    super.key,
  });

  /// [tareSum] - общая сумма тары
  /// [taraProductInfo] - информация о таре
  final int tareSum;
  final String taraProductInfo;

  /// показывает faq (всплывающее окно) по возврату тары общая сумма
  Future<dynamic> _showOtherTareFaq(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: context.colors.mainColors.bgCard,
          shape: const RoundedRectangleBorder(
            borderRadius: AppBorders.kCircular12,
          ),
          contentPadding: AppInsets.kHorizontal16 + AppInsets.kTop24,
          actionsPadding: AppInsets.kHorizontal8,
          content: Text(
            taraProductInfo,
            style: context.textStyle.textTypo.tx2Medium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                t.cart.close,
                style: context.textStyle.textTypo.tx2SemiBold,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              t.cart.polycarbonateTare,
              style: context.textStyle.textTypo.tx2Medium,
            ),
          ),
          GestureDetector(
            onTap: () async => _showOtherTareFaq(context),
            child: Assets.icons.question.svg(),
          ),
          AppBoxes.kWidth12,
          Text(
            '$tareSum ${t.common.rub}',
            style: context.textStyle.textTypo.tx1SemiBold,
          ),
        ],
      );
}
