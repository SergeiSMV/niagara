import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'address_selection_event.dart';
part 'address_selection_state.dart';
part 'address_selection_bloc.freezed.dart';

@lazySingleton
class AddressSelectionBloc
    extends Bloc<AddressSelectionEvent, AddressSelectionState> {
  AddressSelectionBloc() : super(const _Initial()) {
    on<AddressSelectionEvent>((event, emit) {});
  }
}
