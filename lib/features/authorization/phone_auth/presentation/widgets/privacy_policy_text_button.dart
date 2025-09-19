import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../core/common/presentation/router/app_router.gr.dart';
import '../../../../../core/utils/constants/app_insets.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/enums/policy_type.dart';
import '../../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../bloc/privacy_check_cubit/privacy_check_cubit.dart';
import 'auth_checkbox.dart';

/// Виджет с текстом пользовательского соглашения и политики конфиденциальности.
/// При нажатии на текст должен вызываться соответствующий метод/экран
class PrivacyPolicyTextButtons extends StatelessWidget {
  const PrivacyPolicyTextButtons({
    required GlobalKey<FormBuilderState> formKey,
    super.key,
  }) : _formKey = formKey;

  // Ключ формы для валидации номера телефона.
  final GlobalKey<FormBuilderState> _formKey;

  /// Создает текст с кнопкой для перехода к пользовательскому соглашению
  /// или политике конфиденциальности
  TextSpan _buildTextButton(
    BuildContext context, {
    required String text,
    required VoidCallback onTap,
  }) =>
      TextSpan(
        text: text,
        style: context.textStyle.textTypo.tx2Medium.copyWith(
          color: context.colors.infoColors.blue,
          decoration: TextDecoration.underline,
          decorationColor: context.colors.infoColors.blue,
        ),
        recognizer: TapGestureRecognizer()..onTap = onTap,
      );

  /// Переключает состояние чекбокса пользовательского соглашения
  /// и политики конфиденциальности
  void _togglePrivacyPolicy(BuildContext context, bool value) =>
      context.read<PrivacyCheckCubit>().setUser(value);

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppInsets.kHorizontal16,
        child: Row(
          children: [
            BlocBuilder<PrivacyCheckCubit, ({bool user, bool marketing})>(
              buildWhen: (previous, current) => previous.user != current.user,
              builder: (context, state) => AuthCheckbox(
                value: state.user,
                onChanged: (value) => _togglePrivacyPolicy(context, value),
              ),
            ),
            const SizedBox(width: AppSizes.kGeneral16),
            Expanded(
              child: Text.rich(
                t.auth.privacyPolicy(
                  userAgreement: (text) => _buildTextButton(
                    context,
                    text: text,
                    onTap: () async {
                      _formKey.currentState?.saveAndValidate();
                      await context.pushRoute(
                        PolicyRoute(type: PolicyType.agreement),
                      );
                    },
                  ),
                  privacyPolicy: (text) => _buildTextButton(
                    context,
                    text: text,
                    onTap: () async {
                      _formKey.currentState?.saveAndValidate();
                      await context.pushRoute(
                        PolicyRoute(type: PolicyType.confidence),
                      );
                    },
                  ),
                ),
                style: context.textStyle.textTypo.tx2Medium,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      );
}
