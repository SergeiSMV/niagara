import 'package:niagara_app/features/catalog/data/remote/dto/group_dto.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';

extension GroupMapperDto on GroupDto {
  Group toModel() => Group(
        name: group ?? '',
        id: groupId ?? '',
        image: image ?? '',
      );
}
