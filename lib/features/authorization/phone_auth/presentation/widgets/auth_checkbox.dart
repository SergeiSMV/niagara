import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';

/// Виджет с чекбоксом для авторизации
class AuthCheckbox extends StatelessWidget {
  const AuthCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// Значение чекбокса
  final bool value;

  /// Callback для изменения значения чекбокса
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) => Checkbox(
        side: BorderSide(
          color: context.colors.mainColors.primary,
          width: AppSizes.kGeneral2,
        ),
        activeColor: context.colors.mainColors.primary,
        value: value,
        onChanged: (value) => onChanged(value ?? false),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      );
}
