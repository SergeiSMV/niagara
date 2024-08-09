import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/date_selection_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/list_time_slots_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/get_dates_cubit/get_dates_cubit.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/get_time_slots_cubit/get_time_slots_cubit.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/order_cleaning_equipment_cubit/order_cleaning_equipment_cubit.dart';

/// Виджет выбора даты и временных слотов
class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({
    super.key,
    required this.locationId,
  });

  /// [locationId] - идентификатор локации оборудования
  final String locationId;

  /// [_loadingWidget] - виджет загрузки
  Widget get _loadingWidget => const Center(
        child: SizedBox(
          height: AppSizes.kLoaderSmall,
          width: AppSizes.kLoaderSmall,
          child: AppCenterLoader(
            size: AppSizes.kLoaderSmall,
          ),
        ),
      );

  /// [_getTimeSlots] - метод получения временных слотов
  void _getTimeSlots(BuildContext context, DateTime date) =>
      context.read<GetTimeSlotsCubit>().getTimeSlots(locationId, date);

  void _getDatesListener(BuildContext context, GetDatesState state) =>
      state.maybeWhen(
        loaded: (dates, firstLoad) {
          /// Если первая загрузка, то получаем временные слоты с первой датой
          if (firstLoad) {
            _getTimeSlots(context, dates.first);
            context.read<OrderCleaningEquipmentCubit>().selectedDate =
                dates.first;
          }
          return null;
        },
        orElse: () => null,
      );

  @override
  Widget build(BuildContext context) {
    final orderCleaningCubit = context.read<OrderCleaningEquipmentCubit>();

    return SliverToBoxAdapter(
      child: BlocBuilder<GetTimeSlotsCubit, GetTimeSlotsState>(
        builder: (context, getTimeSlotsState) {
          return BlocConsumer<GetDatesCubit, GetDatesState>(
            listener: _getDatesListener,
            builder: (context, getDatesState) {
              return getDatesState.when(
                loading: () => _loadingWidget,
                empty: () => const SizedBox.shrink(),
                error: () => const SizedBox.shrink(),
                loaded: (dates, _) => Padding(
                  padding: AppInsets.kVertical16 + AppInsets.kTop8,
                  child: Column(
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
                        selectableDates: dates,
                        onValueChanged: (date) {
                          orderCleaningCubit.selectedDate = date;
                          orderCleaningCubit.selectedTimeSlot = null;
                          _getTimeSlots(context, date);
                        },
                        selectedDate: orderCleaningCubit.selectedDate,
                      ),
                      AppBoxes.kHeight16,
                      getTimeSlotsState.when(
                        loading: () => _loadingWidget,
                        empty: () => const SizedBox.shrink(),
                        error: () => const SizedBox.shrink(),
                        loaded: (timeSlots) => ListTimeSlotsWidget(
                          timeSlots: timeSlots,
                          onValueChanged: (timeSlot) {
                            orderCleaningCubit.selectedTimeSlot = timeSlot;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
