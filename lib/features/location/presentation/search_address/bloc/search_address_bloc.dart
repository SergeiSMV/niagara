import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/extensions/flutter_bloc_ext.dart';
import 'package:niagara_app/features/location/domain/usecases/search_by_text.dart';

part 'search_address_bloc.freezed.dart';
part 'search_address_event.dart';
part 'search_address_state.dart';

typedef _Emit = Emitter<SearchAddressState>;

@lazySingleton
class SearchAddressBloc extends Bloc<SearchAddressEvent, SearchAddressState> {
  SearchAddressBloc({
    required SearchByTextUseCase searchByTextUseCase,
  })  : _searchByTextUseCase = searchByTextUseCase,
        super(const SearchAddressState.initial()) {
    on<SearchAddressEvent>(
      _onSearchAddress,
      transformer: debounce(),
    );
  }

  final SearchByTextUseCase _searchByTextUseCase;

  Future<void> _onSearchAddress(SearchAddressEvent event, _Emit emit) async {
    if (event.input != null && event.input!.isNotEmpty) {
      await _searchByTextUseCase.call(event.input!);
    }
  }
}
