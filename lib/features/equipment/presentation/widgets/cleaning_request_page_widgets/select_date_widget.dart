import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/date_selection_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/list_time_slots_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/get_time_slots_cubit/get_time_slots_cubit.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({
    super.key,
    required this.locationId,
  });

  final String locationId;

  void _getTimeSlots(BuildContext context, DateTime date) {
    /// В таком формате метод получения временных слотов принимает дату
    /// год :: месяц :: день
    final formatDate = DateFormat('yyyyMMdd').format(date);
    context.read<GetTimeSlotsCubit>().getTimeSlots(locationId, formatDate);
  }

  @override
  Widget build(BuildContext context) {
    _getTimeSlots(context, DateTime.now());

    return SliverToBoxAdapter(
      child: Padding(
        padding: AppInsets.kVertical16 + AppInsets.kTop8,
        child: BlocBuilder<GetTimeSlotsCubit, GetTimeSlotsState>(
          builder: (context, getTimeSlotsState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppInsets.kHorizontal16,
                  child: Text(
                    t.equipments.selectCleaningDate,
                    style: context.textStyle.textTypo.tx1SemiBold
                        .withColor(context.colors.textColors.main),
                  ),
                ),
                AppBoxes.kHeight12,
                DateSelectionWidget(
                  firstDate: DateTime.now(),
                  secondDate: DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day + 1),
                  onValueChanged: (date) => _getTimeSlots(context, date),
                  calendarValue: DateTime.now(),
                ),
                AppBoxes.kHeight16,
                getTimeSlotsState.when(
                  loading: () => const Center(
                    child: SizedBox(
                      height: AppSizes.kLoaderSmall,
                      width: AppSizes.kLoaderSmall,
                      child: AppCenterLoader(
                        size: AppSizes.kLoaderSmall,
                      ),
                    ),
                  ),
                  empty: () => const SizedBox.shrink(),
                  error: () => const SizedBox.shrink(),
                  loaded: (timeSlots) =>
                      ListTimeSlotsWidget(timeSlots: timeSlots),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
