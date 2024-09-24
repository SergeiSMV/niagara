import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/time_slot_selection_cubit/time_slot_selection_cubit.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

class TimeSlotWidget extends StatelessWidget {
  const TimeSlotWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final selectedTimeSlotId =
        context.watch<TimeSlotSelectionCubit>().selectedTimeSlotId;

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selectedTimeSlotId == title
              ? context.colors.textColors.accent
              : context.colors.mainColors.bgCard,
          borderRadius: AppBorders.kCircular6,
        ),
        child: Center(
          child: Text(
            title,
            style: context.textStyle.textTypo.tx2Medium.withColor(
              selectedTimeSlotId == title
                  ? context.colors.textColors.white
                  : context.colors.textColors.main,
            ),
          ),
        ),
      ),
    );
  }
}
