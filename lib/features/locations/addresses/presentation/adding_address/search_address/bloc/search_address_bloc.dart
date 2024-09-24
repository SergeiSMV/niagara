import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/use_cases/geocoder/search_addresses_by_text_use_case.dart';

part 'search_address_bloc.freezed.dart';
part 'search_address_event.dart';
part 'search_address_state.dart';

typedef _Emit = Emitter<SearchAddressState>;

@injectable
class SearchAddressBloc extends Bloc<SearchAddressEvent, SearchAddressState> {
  SearchAddressBloc(
    this._searchByTextUseCase,
  ) : super(const _Initial()) {
    on<SearchAddressEvent>(
      _onSearchAddress,
      transformer: debounce(),
    );
  }

  final SearchAddressesByTextUseCase _searchByTextUseCase;

  Future<void> _onSearchAddress(SearchAddressEvent event, _Emit emit) async {
    emit(const _Loading());
    if (event.input != null && event.input!.isNotEmpty) {
      await _searchByTextUseCase.call(event.input!).fold(
            (failure) => emit(const _Error()),
            (locations) => emit(
              locations.isEmpty ? const _Error() : _Loaded(locations),
            ),
          );
    } else {
      emit(const _Initial());
    }
  }
}
