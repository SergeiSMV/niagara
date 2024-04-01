import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

// TODO(Oleg): Добавить ссылки на пользовательское соглашение и оферту.

/// Виджет с текстом пользовательского соглашения, политики конфиденциальности
/// и оферты. При нажатии на текст должен вызываться соответствующий метод/экран
class PrivacyPolicyTextButtons extends StatelessWidget {
  /// Создает виджет с текстом пользовательского соглашения,
  /// политики конфиденциальности.
  const PrivacyPolicyTextButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      t.auth.privacyPolicy(
        userAgreement: (text) => _buildTextButton(
          context,
          text: text,
          onTap: () => debugPrint('userAgreement'),
        ),
        privacyPolicy: (text) => _buildTextButton(
          context,
          text: text,
          onTap: () => debugPrint('privacyPolicy'),
        ),
        offer: (text) => _buildTextButton(
          context,
          text: text,
          onTap: () => debugPrint('offer'),
        ),
      ),
      style: context.textStyle.textTypo.tx2Medium,
      textAlign: TextAlign.center,
    ).paddingSymmetric(horizontal: AppConst.kPaddingMax);
  }

  TextSpan _buildTextButton(
    BuildContext context, {
    required String text,
    required VoidCallback onTap,
  }) {
    return TextSpan(
      text: text,
      style: context.textStyle.textTypo.tx2Medium.copyWith(
        color: context.colors.infoColors.blue,
        decoration: TextDecoration.underline,
        decorationColor: context.colors.infoColors.blue,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}
