import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class BonusHistoryTile extends StatelessWidget {
  const BonusHistoryTile({
    required this.title,
    required this.date,
    required this.count,
    this.isTemp = false,
    super.key,
  });

  final String title;
  final DateTime date;
  final int count;
  final bool isTemp;

  @override
  Widget build(BuildContext context) {
    final isNegativeCount = count < 0;
    final countColor = isNegativeCount
        ? context.colors.infoColors.red
        : context.colors.infoColors.green;

    final currentLocale = LocaleSettings.currentLocale.name;
    final dateFormat = DateFormat('dd MMMM, HH:mm', currentLocale);
    final formattedDate = dateFormat.format(date);

    return ListTile(
      contentPadding: AppConst.kCommon16.horizontal,
      title: Row(
        children: [
          Text(
            title,
            style: context.textStyle.textTypo.tx1Medium.withColor(
              context.colors.textColors.main,
            ),
          ),
          if (isTemp)
            Assets.icons.fire
                .svg(
                  width: AppConst.kIconMedium,
                  height: AppConst.kIconMedium,
                )
                .padding(left: AppConst.kCommon4),
        ],
      ),
      subtitle: Text(
        formattedDate,
        style: context.textStyle.descriptionTypo.des3.withColor(
          context.colors.textColors.secondary,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${isNegativeCount ? '' : '+'}$count',
            style: context.textStyle.textTypo.tx2Medium.withColor(countColor),
          ),
          AppConst.kCommon6.horizontalBox,
          Assets.icons.coinNiagara.svg(
            width: AppConst.kIconMedium,
            height: AppConst.kIconMedium,
          ),
        ],
      ),
    );
  }
}
