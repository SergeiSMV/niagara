import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/policy_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Виджет с текстом пользовательского соглашения и политики конфиденциальности.
/// При нажатии на текст должен вызываться соответствующий метод/экран
class PrivacyPolicyTextButtons extends StatelessWidget {
  const PrivacyPolicyTextButtons({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16,
      child: Text.rich(
        t.auth.privacyPolicy(
          userAgreement: (text) => _buildTextButton(
            context,
            text: text,
            onTap: () => context.navigateTo(
              PolicyRoute(type: PolicyType.agreement),
            ),
          ),
          privacyPolicy: (text) => _buildTextButton(
            context,
            text: text,
            onTap: () => context.navigateTo(
              PolicyRoute(type: PolicyType.confidence),
            ),
          ),
        ),
        style: context.textStyle.textTypo.tx2Medium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
