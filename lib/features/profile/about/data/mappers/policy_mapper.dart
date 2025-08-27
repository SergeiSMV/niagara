import 'package:drift/drift.dart';

import '../../../../../core/common/data/database/app_database.dart';
import '../../../../../core/utils/enums/policy_type.dart';
import '../../domain/model/policy.dart';
import '../local/entity/policy.dart';
import '../remote/dto/policy_dto.dart';

/// Расширение для преобразования PolicyDto в Policy
extension PolicyDtoMapper on PolicyDto {
  Policy toModel() => Policy(
        html: html,
      );
}

/// Расширение для преобразования PolicyEntity в Policy
extension PolicyEntityMapper on PolicyEntity {
  Policy toModel() => Policy(
        html: html,
      );

  PoliciesTableCompanion toCompanion() => PoliciesTableCompanion(
        html: Value(html),
        type: Value(type.name),
      );
}

/// Расширение для преобразования Policy в PolicyEntity
extension PolicyMapper on Policy {
  PolicyEntity toEntity(PolicyType type) => PolicyEntity(
        html: html,
        type: type,
      );
}

/// Расширение для преобразования PoliciesTableData в PolicyEntity
extension PoliciesTableExtension on PoliciesTableData {
  PolicyEntity toEntity() => PolicyEntity(
        html: html,
        type: PolicyType.toEnum(type),
      );
}
