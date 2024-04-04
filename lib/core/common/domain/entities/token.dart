part of '../../../core.dart';

/// Сущность токена доступа для всех запросов
class Token extends Equatable {
  /// - [token] - токен доступа
  const Token({
    required this.token,
  });

  /// Токен доступа
  final String token;

  @override
  List<Object?> get props => [token];
}
