// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';

class ReferralItemDto extends Equatable {
  final String text;
  final String? image;

  @override
  List<Object?> get props => [text, image];

  const ReferralItemDto({
    required this.text,
    required this.image,
  });

  factory ReferralItemDto.fromJson(Map<String, dynamic> json) =>
      ReferralItemDto(
        text: json['text'] as String,
        image: json['image'] as String?,
      );
}
