import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/domain/repositories/geocoder_repository.dart';

@injectable
class SearchAddressesByTextUseCase extends BaseUseCase<List<Address>, String> {
  SearchAddressesByTextUseCase(this._geocoder);

  final IGeocoderRepository _geocoder;

  @override
  Future<Either<Failure, List<Address>>> call(String params) async =>
      _geocoder.getAddressesByQuery(query: params);
}
