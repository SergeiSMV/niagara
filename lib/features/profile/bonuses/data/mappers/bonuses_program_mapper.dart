import 'package:niagara_app/core/utils/enums/status_level_type.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/about_bonus_program_dto.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/activation_option_dto.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/faq_bonuses_dto.dart';
import 'package:niagara_app/features/profile/bonuses/data/remote/dto/status_description_dto.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/about_bonus_program.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/activation_option.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/faq_bonuses.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';

extension AboutBonusProgramMapper on AboutBonusProgramDto {
  AboutBonusProgram toModel() => AboutBonusProgram(
        privileges: privilege.map((e) => e.toModel()).toList(),
        mainBonuses: bonusMain.map((e) => e.titleText).toList(),
        temporaryBonuses: bonusTemp.map((e) => e.titleText).toList(),
      );
}

extension PrivilegeMapper on PrivilegeDto {
  Privilege toModel() => Privilege(
        title: titleName,
        description: titleText,
        image: BenefitPicture.fromString(titlePict),
      );
}

extension StatusesDescriptionMapper on StatusDescriptionDto {
  StatusDescription toModel() => StatusDescription(
        level: StatusLevel.parseStatusLevel(name.toLowerCase()),
        description: description,
        minSum: minSum,
        maxSum: maxSum,
        benefits: benefits.map((e) => e.toModel()).toList(),
        activationOptions: activationOptions?.map((e) => e.toModel()).toList(),
      );
}

extension BenefitMapper on BenefitDto {
  BenefitDescription toModel() => BenefitDescription(
        title: titleName,
        titleShort: titleNameSmall,
        descriptionShort: titleTextSmall,
        description: titleText,
        picture: BenefitPicture.fromString(titlePict),
      );
}

extension FaqBonusesMapper on FaqBonusesDto {
  FaqBonuses toModel() => FaqBonuses(
        question: question,
        answer: answer,
      );
}

extension ActivationOptionMapper on ActivationOptionDto {
  ActivationOption toModel() => ActivationOption(
        title: title,
        description: description,
        count: count.toString(),
        descriptionFull: descriptionFull,
        label: label.isNotEmpty ? label : null,
        sum: sum.toString(),
        sumForMounth: sumForMounth.toString(),
      );
}
