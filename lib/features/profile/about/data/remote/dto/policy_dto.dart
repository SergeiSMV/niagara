import 'package:equatable/equatable.dart';

class PolicyDto extends Equatable {
  const PolicyDto({required this.html});

  final String html;

  @override
  List<Object?> get props => [html];
}
