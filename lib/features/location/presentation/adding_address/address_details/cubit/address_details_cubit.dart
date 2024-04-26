import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';

@injectable
class AddressDetailsCubit extends Cubit<Location> {
  AddressDetailsCubit({
    @factoryParam required Location location,
  })  : _location = location,
        super(location);

  final Location _location;

  /// Обновляет дополнительные данные адреса
  Future<void> updateAddressData({
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) async {
    emit(
      _location.copyWithoutDetails(
        flat: flat ?? _location.flat,
        entrance: entrance ?? _location.entrance,
        floor: floor ?? _location.floor,
        comment: comment ?? _location.description,
      ),
    );
  }
}
