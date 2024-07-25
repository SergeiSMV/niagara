import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';

class StatusDescription extends Equatable {
  const StatusDescription({
    required this.level,
    required this.description,
    required this.minSum,
    required this.maxSum,
    required this.benefits,
    this.activationOptions,
  });

  final StatusLevel level;
  final String description;
  final int minSum;
  final int maxSum;
  final List<BenefitDescription> benefits;
  final List<ActivationOption>? activationOptions;

  @override
  List<Object?> get props => [level, description, minSum, maxSum, benefits];
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
