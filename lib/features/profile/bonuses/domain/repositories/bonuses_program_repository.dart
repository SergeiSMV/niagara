import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/bonuses_program.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';

abstract interface class IBonusesProgramRepository {
  Future<Either<Failure, BonusesProgram>> getBonusesProgram();
  Future<Either<Failure, StatusDescription>> getStatus(StatusLevel status);
}
