import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/shops/domain/models/shop.dart';
import 'package:niagara_app/features/locations/shops/domain/use_cases/get_shops_use_case.dart';

part 'shops_bloc.freezed.dart';
part 'shops_event.dart';
part 'shops_state.dart';

@injectable
class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  ShopsBloc(
    this._getShopsUseCase,
  ) : super(const _Initial()) {
    on<_LoadingEvent>(_onStarted);
    on<_SelectShopEvent>(_onSelectShop);
    on<_UnselectShopEvent>(_onUnselectShop);

    add(const _LoadingEvent());
  }

  final GetShopsUseCase _getShopsUseCase;

  Future<void> _onStarted(_LoadingEvent event, Emitter<ShopsState> emit) async {
    emit(const _Loading());
    await _getShopsUseCase.call().fold(
          (failure) => emit(_Error(failure.error)),
          (shops) => emit(ShopsState.loaded(shops: shops)),
        );
  }

  void _onSelectShop(_SelectShopEvent event, Emitter<ShopsState> emit) {
    final shops = state.maybeWhen(
      loaded: (shops) => shops,
      selectShop: (shop, shops) => shops,
      orElse: () => <Shop>[],
    );
    emit(ShopsState.selectShop(shop: event.shop, shops: shops));
  }

  void _onUnselectShop(_UnselectShopEvent event, Emitter<ShopsState> emit) {
    emit(ShopsState.loaded(shops: state.shops));
  }
}
