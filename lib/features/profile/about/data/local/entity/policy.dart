import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/core/utils/enums/policy_type.dart';

/// Сущность политики для работы с БД.
class PolicyEntity extends Equatable {
  const PolicyEntity({
    required this.html,
    required this.type,
  });

  final String html;
  final PolicyType type;

  @override
  List<Object?> get props => [html, type];
}
