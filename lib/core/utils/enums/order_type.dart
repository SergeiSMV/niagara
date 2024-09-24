/// Тип заказа: ВИП-подписка или пополнение баланса предоплатной воды.
enum OrderType {
  vip,
  prepaidWater;

  /// Возвращает `true`, если тип заказа - ВИП-подписка.
  bool get isVip => this == OrderType.vip;

  /// Возвращает `true`, если тип заказа - пополнение баланса предоплатной воды.
  bool get isWater => this == OrderType.prepaidWater;
}
