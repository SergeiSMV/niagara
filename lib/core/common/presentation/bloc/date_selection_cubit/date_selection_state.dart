part of 'date_selection_cubit.dart';

@freezed
class DateSelectionState with _$DateSelectionState {
  const factory DateSelectionState.selected({
    required DateSelectionItems dateItem,
  }) = _Selected;
}
