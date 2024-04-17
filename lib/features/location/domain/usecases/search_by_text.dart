import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/location/domain/repositories/geocoder_repository.dart';

@injectable
class SearchByTextUseCase extends UseCase<void, String> {
  SearchByTextUseCase({
    required IGeocoderRepository geocoder,
  }) : _geocoder = geocoder;

  final IGeocoderRepository _geocoder;

  @override
  Future<Either<Failure, void>> call(String params) async =>
      _geocoder.getAddressesByQuery(query: params);
}
