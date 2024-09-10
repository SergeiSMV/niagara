import 'package:flutter/material.dart';

/// Баннер для перехода на страницу предоплатной воды.
///
/// Отображает количество доступной предоплатной воды на балансе.
class PrepaidWaterBanner extends StatelessWidget {
  const PrepaidWaterBanner({super.key, required this.count});

  /// Количество доступной предоплатной воды.
  final int count;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
