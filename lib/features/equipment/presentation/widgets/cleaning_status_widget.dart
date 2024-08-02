import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/cleaning_statuses.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

class CleaningStatusWidget extends StatelessWidget {
  const CleaningStatusWidget({
    super.key,
    required this.status,
  });

  final CleaningStatuses status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppInsets.kHorizontal4 + AppInsets.kVertical6,
      decoration: BoxDecoration(
        borderRadius: AppBorders.kCircular4,
        color: status == CleaningStatuses.cleaningIsRequired
            ? context.colors.infoColors.red
            : context.colors.infoColors.green,
      ),
      child: Text(
        status.toLocale(),
        style: context.textStyle.captionTypo.c1
            .withColor(context.colors.mainColors.white),
      ),
    );
  }
}
