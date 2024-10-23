// ignore_for_file: sort_constructors_first

import 'package:niagara_app/core/core.dart';

class BannerDto extends Equatable {
  const BannerDto({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.type,
    required this.link,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String type;
  final String link;

  factory BannerDto.fromJson(Map<String, dynamic> json) {
    return BannerDto(
      id: json['ID'] as String,
      name: json['NAME'] as String,
      // TODO: Регулярка нужна, чтобы удалить лишние `https://` из ссылки.
      imageUrl: (json['IMAGE'] as String)
          .replaceAll(RegExp(r'(https:\/\/)+'), 'https://'),
      type: json['TYPE'] as String,
      link: json['LINK'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        type,
        link,
      ];
}
