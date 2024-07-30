import 'package:niagara_app/features/profile/about/data/remote/dto/policy_dto.dart';
import 'package:niagara_app/features/profile/about/domain/model/policy.dart';

extension PolicyMapper on PolicyDto {
  Policy toModel() => Policy(
        html: html,
      );
}
