import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';

class StatusDescription extends Equatable {
  const StatusDescription({
    required this.level,
    required this.description,
    required this.benefits,
  });

  final StatusLevel level;
  final String description;
  final List<BenefitDescription> benefits;

  @override
  List<Object?> get props => [level, description, benefits];
}

class BenefitDescription extends Equatable {
  const BenefitDescription({
    required this.title,
    required this.description,
    required this.picture,
  });

  final String title;
  final String description;
  final BenefitPicture picture;

  @override
  List<Object?> get props => [title, description, picture];
}
