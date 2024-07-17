part of 'new_products_bloc.dart';

@freezed
class NewProductsEvent with _$NewProductsEvent {
  const factory NewProductsEvent.loading() = _LoadingNewProductsEvent;
  const factory NewProductsEvent.loadMore() = _LoadingMoreNewProductsEvent;
}
