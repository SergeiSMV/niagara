import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет для ввода номера телефона.
class EnterPhoneWidget extends StatelessWidget {
  /// Создает экземпляр [EnterPhoneWidget].
  const EnterPhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      t.auth.enterPhone,
      style: context.textStyle.headingTypo.h3,
    );
  }
}
