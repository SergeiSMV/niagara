import 'package:auto_route/auto_route.dart';

/// Класс [BaseRouters] - базовый класс для маршрутизаторов приложения.
/// Наследники данного класса должны реализовывать метод [routers] и возвращать
/// маршруты, которые будут доступны в приложении.
abstract class BaseRouters {
  /// Возвращает список маршрутов, которые будут доступны.
  AutoRoute get routers;
}
