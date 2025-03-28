import 'package:flutter/material.dart';
import '../../../../../core/common/presentation/widgets/countdown_timer_widget.dart';
import '../../../../../core/utils/constants/app_borders.dart';
import '../../../../../core/utils/constants/app_boxes.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../../core/utils/gen/assets.gen.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../../domain/models/bonuses.dart';

class YearlyBonusesWidget extends StatelessWidget {
  const YearlyBonusesWidget(this.bonuses, {super.key});

  final Bonuses bonuses;

  EdgeInsetsGeometry get _padding =>
      AppInsets.kHorizontal16 + AppInsets.kTop16 + AppInsets.kBottom24;

  BorderRadiusGeometry get _borderRadius => AppBorders.kCircular12;

  ImageProvider<Object> get _image => Assets.images.yearlyBonuses.provider();

  @override
  Widget build(BuildContext context) => Container(
        padding: _padding,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          image: DecorationImage(
            image: _image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Text(
              t.bonuses.yearlyBonuses,
              style: context.textStyle.headingTypo.h2
                  .withColor(context.colors.mainColors.white),
            ),
            AppBoxes.kHeight12,
            Text(
              t.bonuses.yearlyBonusesDesc,
              style: context.textStyle.textTypo.tx2Medium.withColor(
                context.colors.mainColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            AppBoxes.kHeight24,
            TimerCountdown(
              endTime: bonuses.yearlyBonusDate,
              daysDescription: t.bonuses.days,
              hoursDescription: t.bonuses.hours,
              minutesDescription: t.bonuses.minutes,
              timeTextStyle: context.textStyle.headingTypo.h2
                  .withColor(context.colors.buttonColors.accent),
              descriptionTextStyle: context.textStyle.textTypo.tx3SemiBold
                  .withColor(context.colors.textColors.white),
              colonsTextStyle: context.textStyle.headingTypo.h2
                  .withColor(context.colors.textColors.white),
              format: CountDownTimerFormat.daysHoursMinutes,
            ),
          ],
        ),
      );
}
