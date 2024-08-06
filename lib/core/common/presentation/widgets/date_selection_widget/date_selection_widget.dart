import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  });

  final String firstDate;
  final String secondDate;

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
            value: DateTime.now(),
            onValueChanged: (time) {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
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
                    title: firstDate,
                    isSelected: selected == DateSelectionItems.firstDate,
                    onTap: () =>
                        _selectDate(context, DateSelectionItems.firstDate),
                  ),
                  DateItemWidget(
                    title: secondDate,
                    isSelected: selected == DateSelectionItems.secondDate,
                    onTap: () =>
                        _selectDate(context, DateSelectionItems.secondDate),
                  ),
                  DateItemWidget(
                    title: t.equipments.choose,
                    isSelected: selected == DateSelectionItems.select,
                    showingDatePicker: true,
                    onTap: () {
                      _selectDate(context, DateSelectionItems.select);
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
