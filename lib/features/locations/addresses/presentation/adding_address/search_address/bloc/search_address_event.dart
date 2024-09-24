part of 'search_address_bloc.dart';

@freezed
class SearchAddressEvent with _$SearchAddressEvent {
  const factory SearchAddressEvent.inputChanged(String? input) = _InputChanged;
}
