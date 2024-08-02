import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/profile/about/data/local/entity/policy.dart';
import 'package:niagara_app/features/profile/about/data/remote/dto/policy_dto.dart';
import 'package:niagara_app/features/profile/about/domain/model/policy.dart';

extension PolicyDtoMapper on PolicyDto {
  Policy toModel() => Policy(
        html: html,
      );
}

extension PolicyEntityMapper on PolicyEntity {
  Policy toModel() => Policy(
        html: html,
      );

  PoliciesTableCompanion toCompanion() => PoliciesTableCompanion(
        html: Value(html),
        type: Value(type.name),
      );
}

extension PolicyMapper on Policy {
  PolicyEntity toEntity(PolicyType type) => PolicyEntity(
        html: html,
        type: type,
      );
}

extension PoliciesTableExtension on PoliciesTableData {
  PolicyEntity toEntity() => PolicyEntity(
        html: html,
        type: PolicyType.toEnum(type),
      );
}
