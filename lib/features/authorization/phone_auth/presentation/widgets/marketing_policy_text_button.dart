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

/// Виджет с текстом маркетингового соглашения
/// При нажатии на текст должен вызываться соответствующий метод/экран
class MarketingPolicyTextButton extends StatelessWidget {
  const MarketingPolicyTextButton({
    required GlobalKey<FormBuilderState> formKey,
    super.key,
  }) : _formKey = formKey;

  // Ключ формы для валидации номера телефона.
  final GlobalKey<FormBuilderState> _formKey;

  /// Создает текст с кнопкой для перехода к маркетинговому соглашению
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

  /// Переключает состояние чекбокса маркетингового соглашения
  void _toggleMarketingPolicy(BuildContext context, bool value) =>
      context.read<PrivacyCheckCubit>().setMarketing(value);

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppInsets.kHorizontal16,
        child: Row(
          children: [
            BlocBuilder<PrivacyCheckCubit, ({bool user, bool marketing})>(
              buildWhen: (previous, current) =>
                  previous.marketing != current.marketing,
              builder: (context, state) => AuthCheckbox(
                value: state.marketing,
                onChanged: (value) => _toggleMarketingPolicy(context, value),
              ),
            ),
            const SizedBox(width: AppSizes.kGeneral16),
            Expanded(
              child: Text.rich(
                t.auth.marketingAgreement(
                  marketingAgreement: (text) => _buildTextButton(
                    context,
                    text: text,
                    onTap: () async {
                      _formKey.currentState?.saveAndValidate();
                      await context.pushRoute(
                        PolicyRoute(type: PolicyType.marketing),
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
