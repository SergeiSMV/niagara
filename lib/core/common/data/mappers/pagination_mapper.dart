import 'package:niagara_app/core/common/data/remote/dto/pagination_dto.dart';
import 'package:niagara_app/core/common/domain/models/pagination.dart';

extension PaginationMapper on PaginationDto {
  Pagination toModel() => Pagination(
        current: current,
        total: total,
      );
}
