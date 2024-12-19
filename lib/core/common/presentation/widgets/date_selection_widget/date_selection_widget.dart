import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:niagara_app/core/common/presentation/bloc/date_selection_cubit/date_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/date_item_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/date_selection_widget/table_calendar_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/date_selection_items.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет выбора даты
class DateSelectionWidget extends StatelessWidget {
  const DateSelectionWidget({
    super.key,
    required this.selectableDates,
    required this.onValueChanged,
    this.selectedDate,
  });

  /// [selectableDates] - диапазон дат, которые можно выбрать
  final List<DateTime> selectableDates;

  /// [_firstDate] - первая ближайшая дата
  DateTime? get _firstDate =>
      selectableDates.isNotEmpty ? selectableDates.first : null;

  /// [_secondDate] - вторая ближайшая дата
  DateTime? get _secondDate =>
      selectableDates.length > 1 ? selectableDates[1] : null;

  /// [onValueChanged] - функция изменения даты, возвращает [DateTime]
  final Function(DateTime) onValueChanged;

  /// [selectedDate] - текущая выбранная дата
  final DateTime? selectedDate;

  /// [_selectDate] - выбор даты
  void _selectDate(BuildContext context, DateSelectionItems item) =>
      context.read<DateSelectionCubit>().selectDate(item);

  /// [_openCalendar] - открытие кастомного календаря
  Future<void> _openCalendar(BuildContext outerContext) async {
    return showDialog(
      context: outerContext,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: TableCalendarWidget(
            selectableDates: selectableDates,
            selectedDate: selectedDate ?? DateTime.now(),
            onValueChanged: (date) {
              onValueChanged(date.first);
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  /// [_getDateText] - получение текста даты (сегодня, завтра, MM.dd.)
  String _getDateText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    /// Метод [isAtSameMomentAs] не подходит, так как различие в датах даже
    /// на миллисекунду вернет false
    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return t.equipments.today;
    } else if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return t.equipments.tomorrow;
    } else {
      return DateFormat('dd.MM.').format(date);
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
        child: BlocBuilder<DateSelectionCubit, DateSelectionState>(
          builder: (context, state) {
            final selected = state.maybeWhen(
              selected: (selected) => selected,
              orElse: () => false,
            );

            return Row(
              children: [
                /// Виджет с первой ближайшей датой
                if (_firstDate != null)
                  DateItemWidget(
                    title: _getDateText(_firstDate!),
                    isSelected: selected == DateSelectionItems.firstDate,
                    onTap: () {
                      onValueChanged(_firstDate!);
                      _selectDate(context, DateSelectionItems.firstDate);
                    },
                  ),

                /// Виджет с второй ближайшей датой
                if (_secondDate != null)
                  DateItemWidget(
                    title: _getDateText(_secondDate!),
                    isSelected: selected == DateSelectionItems.secondDate,
                    onTap: () {
                      onValueChanged(_secondDate!);
                      _selectDate(context, DateSelectionItems.secondDate);
                    },
                  ),

                /// Виджет с выбранной датой
                DateItemWidget(
                  showCalendarIcon: true,
                  title: selectedDate != null &&
                          selected == DateSelectionItems.select
                      ? _getDateText(selectedDate!)
                      : t.equipments.choose,
                  isSelected: selected == DateSelectionItems.select,
                  onTap: () {
                    if (selectedDate != null) {
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
    );
  }
}
