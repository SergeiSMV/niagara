import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'policy_dto.g.dart';

@JsonSerializable(createToJson: false)
class PolicyDto extends Equatable {
  const PolicyDto({required this.html});

  factory PolicyDto.fromJson(Map<String, dynamic> json) =>
      _$PolicyDtoFromJson(json);

  final String html;

  @override
  List<Object?> get props => [html];
}
