import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/models/shop.dart';
import 'package:niagara_app/features/location/domain/usecases/shops/get_shops_use_case.dart';

part 'shops_event.dart';
part 'shops_state.dart';

part 'shops_bloc.freezed.dart';

@lazySingleton
class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  ShopsBloc({
    required GetShopsUseCase getShopsUseCase,
  })  : _getShopsUseCase = getShopsUseCase,
        super(const _Initial()) {
    on<_Started>(_onStarted);

    add(const _Started());
  }

  final GetShopsUseCase _getShopsUseCase;

  Future<void> _onStarted(_Started event, Emitter<ShopsState> emit) async {
    emit(const _Loading());
    await _getShopsUseCase.call().fold(
          (failure) => emit(_Error(failure.error)),
          (shops) => emit(ShopsState.loaded(shops)),
        );
  }
}
