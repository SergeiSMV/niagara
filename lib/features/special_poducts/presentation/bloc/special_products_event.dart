part of 'special_products_bloc.dart';

@freezed
class SpecialProductsEvent with _$SpecialProductsEvent {
  const factory SpecialProductsEvent.loading() = _LoadingSpecialProductsEvent;
  const factory SpecialProductsEvent.loadMore() =
      _LoadingMoreSpecialProductsEvent;
}
