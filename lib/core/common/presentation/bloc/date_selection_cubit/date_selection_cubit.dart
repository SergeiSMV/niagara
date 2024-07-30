import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/date_selection_items.dart';

part 'date_selection_state.dart';
part 'date_selection_cubit.freezed.dart';

@injectable
class DateSelectionCubit extends Cubit<DateSelectionState> {
  DateSelectionCubit()
      : super(
          const DateSelectionState.selected(
            dateItem: DateSelectionItems.firstDate,
          ),
        );

  void selectDate(DateSelectionItems value) {
    final dateItem = state.maybeWhen(
      selected: (dateItem) => dateItem,
      orElse: () {},
    );
    if (dateItem == value) return;
    emit(DateSelectionState.selected(dateItem: value));
  }
}
