// ignore_for_file: sort_constructors_first, public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class TokenModel extends Equatable {
  const TokenModel({
    required this.isValid,
    required this.token,
  });

  @JsonKey(name: 'valid')
  final bool isValid;

  final String? token;

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  @override
  List<Object?> get props => [isValid, token];
}

extension TokenModelExt on TokenModel {
  bool get isSuccessful => isValid && token != null && token!.isNotEmpty;
}
