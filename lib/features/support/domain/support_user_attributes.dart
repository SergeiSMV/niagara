import 'package:jivosdk_plugin/bridge.dart';

import '../../../core/core.dart';

/// Набор атрибутов пользователя для чата службы поддержки.
class SupportUserAttributes extends Equatable {
  const SupportUserAttributes({
    required this.values,
  });

  /// Набор атрибутов пользователя.
  final Map<String, dynamic> values;

  /// Атрибуты для передачи в чат.
  List<JVSessionCustomDataField> get jivoFields => values.entries
      .map(
        (e) => JVSessionCustomDataField(
          e.key,
          null,
          e.value.toString(),
          null,
        ),
      )
      .toList();

  @override
  List<Object?> get props => [values];
}
