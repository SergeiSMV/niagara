import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';

class AboutBonusProgram extends Equatable {
  const AboutBonusProgram({
    required this.privileges,
    required this.mainBonuses,
    required this.temporaryBonuses,
  });

  final List<Privilege> privileges;
  final List<String> mainBonuses;
  final List<String> temporaryBonuses;

  @override
  List<Object?> get props => [privileges, mainBonuses, temporaryBonuses];
}

class Privilege extends Equatable {
  const Privilege({
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final BenefitPicture image;

  @override
  List<Object?> get props => [title, description, image];
}
