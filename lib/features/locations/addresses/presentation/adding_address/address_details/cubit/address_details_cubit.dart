import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';

@injectable
class AddressDetailsCubit extends Cubit<Address> {
  AddressDetailsCubit({
    @factoryParam required Address location,
  })  : _location = location,
        super(location);

  final Address _location;

  bool get hasChanges => _location != state;

  String? _flat;
  String? _entrance;
  String? _floor;
  String? _comment;

  /// Обновляет дополнительные данные адреса
  Future<void> updateAddressData({
    String? flat,
    String? entrance,
    String? floor,
    String? comment,
  }) async {
    _flat = flat;
    _entrance = entrance;
    _floor = floor;
    _comment = comment;

    emit(
      state.copyWithoutDetails(
        flat: _flat,
        entrance: _entrance,
        floor: _floor,
        comment: _comment,
      ),
    );
  }
}
