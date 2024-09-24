import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/about_bonus_program.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/faq_bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';

class BonusesProgram extends Equatable {
  const BonusesProgram({
    required this.aboutBonusProgram,
    required this.statusesDescriptions,
    required this.faqBonuses,
  });

  final AboutBonusProgram aboutBonusProgram;
  final List<StatusDescription> statusesDescriptions;
  final List<FaqBonuses> faqBonuses;

  @override
  List<Object?> get props => [
        aboutBonusProgram,
        statusesDescriptions,
        faqBonuses,
      ];
}
