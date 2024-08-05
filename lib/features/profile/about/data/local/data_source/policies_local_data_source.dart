import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/about/data/local/entity/policy.dart';
import 'package:niagara_app/features/profile/about/data/mappers/policy_mapper.dart';

abstract interface class IPoliciesLocalDataSource {
  Future<Either<Failure, PolicyEntity?>> getPolicy({required String type});

  Future<Either<Failure, void>> setPolicy(PolicyEntity policy);
}

@LazySingleton(as: IPoliciesLocalDataSource)
class PoliciesLocalDataSource implements IPoliciesLocalDataSource {
  PoliciesLocalDataSource(this._db);

  final AppDatabase _db;

  @override
  Future<Either<Failure, PolicyEntity?>> getPolicy({required String type}) =>
      _execute(
        () async {
          final PoliciesTableData? policy =
              await _db.allPolicies.getPolicy(type);
          return policy?.toEntity();
        },
      );

  @override
  Future<Either<Failure, void>> setPolicy(PolicyEntity policy) => _execute(
        () async {
          await _db.allPolicies.insertPolicy(policy.toCompanion());
        },
      );
}

Future<Either<Failure, T>> _execute<T>(Future<T> Function() action) async {
  try {
    final result = await action();
    return Right(result);
  } on Failure catch (e) {
    return Left(e);
  }
}
