import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/time_slot_selection_cubit/time_slot_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/date_selection_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/list_time_slots_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_placing/domain/models/delivery_time_options.dart';
import 'package:niagara_app/features/order_placing/presentation/bloc/create_order/create_order_cubit.dart';
import 'package:niagara_app/features/order_placing/presentation/bloc/delivery_time_options/delivery_time_options_cubit.dart';

class DeliveryDateWidget extends StatelessWidget {
  const DeliveryDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kVertical16 + AppInsets.kTop8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppInsets.kHorizontal16,
            child: Text(
              t.orderPlacing.selectDeliveryDate,
              style: context.textStyle.textTypo.tx1SemiBold
                  .withColor(context.colors.textColors.main),
            ),
          ),
          AppBoxes.kHeight12,
          BlocBuilder<DeliveryTimeOptionsCubit, DeliveryTimeOptionsState>(
            builder: (context, state) => state.when(
              loaded: _DateSelection.new,
              loading: _Loading.new,
              error: _Error.new,
              empty: _Empty.new,
            ),
          ),
        ],
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error({
    super.key,
  });

  void onRefresh(BuildContext context) {
    context.read<DeliveryTimeOptionsCubit>().getOptions();
  }

  @override
  Widget build(BuildContext context) {
    return ErrorRefreshWidget(
      onRefresh: () => onRefresh(context),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kTop8 + AppInsets.kLeft16,
      child: Text(
        t.orderPlacing.noDeliveryDates,
        style: context.textStyle.textTypo.tx2Medium,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Виджет состояния загрузки.
class _Loading extends StatelessWidget {
  const _Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: AppSizes.kLoaderSmall,
        width: AppSizes.kLoaderSmall,
        child: AppCenterLoader(
          size: AppSizes.kLoaderSmall,
        ),
      ),
    );
  }
}

/// Виджет выбора даты и времени.
class _DateSelection extends StatefulWidget {
  const _DateSelection(this.options);

  final List<DeliveryTimeOptions> options;

  @override
  State<_DateSelection> createState() => _DateSelectionState();
}

class _DateSelectionState extends State<_DateSelection> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCreationCubit>().selectedDate = widget.options.first.date;
  }

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.read<OrderCreationCubit>();
    final slotsCubit = context.watch<TimeSlotSelectionCubit>();

    final List<DateTime> selectableDates =
        widget.options.map((e) => e.date).toList()..sort();

    return Column(
      children: [
        DateSelectionWidget(
          onValueChanged: (date) {
            orderCubit.selectedDate = date;
            orderCubit.selectedTimeSlot = null;
            slotsCubit.unselect();
            // TODO: Временное решение, т.к. не происходит обновления состояний
            // у кубита при выборе даты в календаре.
            setState(() {});
          },
          selectableDates: selectableDates,
          selectedDate: orderCubit.selectedDate,
        ),
        AppBoxes.kHeight16,
        ListTimeSlotsWidget(
          timeSlots: widget.options.firstWhereOrNull(
                (e) {
                  final date = e.date;
                  final selected = orderCubit.selectedDate;

                  return selected != null &&
                      date.year == selected.year &&
                      date.month == selected.month &&
                      date.day == selected.day;
                },
              )?.timeSlots ??
              [],
          onValueChanged: (slot) {
            orderCubit.selectedTimeSlot = slot;
          },
        ),
      ],
    );
  }
}
