import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/presentation/bloc/date_selection_cubit/date_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/date_item_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/table_calendar_widget.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/date_selection_items.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет выбора даты
class DateSelectionWidget extends StatelessWidget {
  const DateSelectionWidget({
    super.key,
    required this.firstDate,
    required this.secondDate,
    required this.onValueChanged,
    this.calendarValue,
  });

  final DateTime firstDate;
  final DateTime secondDate;
  final Function(DateTime) onValueChanged;
  final DateTime? calendarValue;

  void _selectDate(BuildContext context, DateSelectionItems item) =>
      context.read<DateSelectionCubit>().selectDate(item);

  Future<void> _openCalendar(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: TableCalendarWidget(
            value: calendarValue ?? DateTime.now(),
            onValueChanged: (date) {
              onValueChanged(date.first);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  String _getDateText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return t.equipments.today;
    } else if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return t.equipments.tomorrow;
    } else {
      return DateFormat('MM.dd.').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Container(
        padding: AppInsets.kAll4,
        decoration: BoxDecoration(
          borderRadius: AppBorders.kCircular12,
          color: context.colors.mainColors.bgCard,
        ),
        child: BlocProvider(
          create: (_) => getIt<DateSelectionCubit>(),
          child: BlocBuilder<DateSelectionCubit, DateSelectionState>(
            builder: (context, state) {
              final selected = state.maybeWhen(
                selected: (selected) => selected,
                orElse: () => false,
              );

              return Row(
                children: [
                  DateItemWidget(
                    title: _getDateText(firstDate),
                    isSelected: selected == DateSelectionItems.firstDate,
                    onTap: () {
                      onValueChanged(firstDate);
                      _selectDate(context, DateSelectionItems.firstDate);
                    },
                  ),
                  DateItemWidget(
                    title: _getDateText(secondDate),
                    isSelected: selected == DateSelectionItems.secondDate,
                    onTap: () {
                      onValueChanged(secondDate);
                      _selectDate(context, DateSelectionItems.secondDate);
                    },
                  ),
                  DateItemWidget(
                    title: calendarValue != null
                        ? _getDateText(calendarValue!)
                        : t.equipments.choose,
                    isSelected: selected == DateSelectionItems.select,
                    onTap: () {
                      if (calendarValue != null) {
                        _selectDate(context, DateSelectionItems.select);
                      }
                      _openCalendar(context);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
