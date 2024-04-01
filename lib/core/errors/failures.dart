// ignore_for_file: public_member_api_docs

part of '../core.dart';

/// Класс [Failure] является базовым классом для всех ошибок, которые могут
/// возникнуть в приложении. Он реализует [Equatable] для сравнения объектов
/// ошибок. Все ошибки должны наследоваться от этого класса.
sealed class Failure extends Equatable {
  /// Создает объект ошибки с дополнительными свойствами [properties].
  const Failure([
    this.properties = const <dynamic>[],
  ]);

  /// Свойство [properties] содержит список дополнительных свойств ошибки.
  final List<dynamic> properties;

  @override
  List<Object?> get props => [properties];
}

class SkipAuthFailure extends Failure {}
