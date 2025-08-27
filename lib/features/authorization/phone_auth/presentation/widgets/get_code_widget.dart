import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../core/common/presentation/widgets/bottom_shadow_widget.dart';
import '../../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/utils/gen/strings.g.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../bloc/privacy_check_cubit/privacy_check_cubit.dart';
import '../bloc/validate_phone_cubit/validate_phone_cubit.dart';

/// Кнопка "Получить код" для отправки кода подтверждения на номер телефона.
class GetCodeWidget extends StatelessWidget {
  const GetCodeWidget({
    required GlobalKey<FormBuilderState> formKey,
    super.key,
  }) : _formKey = formKey;

  // Ключ формы для валидации номера телефона.
  final GlobalKey<FormBuilderState> _formKey;

  /// Обработчик нажатия на кнопку "Получить код"
  void onTapGetCode(BuildContext context) {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final phoneNumber = _formKey
          .currentState?.value[AppConstants.kTextFieldPhoneName]
          .toString();
      if (phoneNumber == null || phoneNumber.isEmpty) return;
      context.read<AuthBloc>().add(AuthEvent.getCode(phoneNumber: phoneNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Проверяем, что загрузка не идет
    final isLoading = context.watch<AuthBloc>().state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

    /// Проверяем, что номер телефона валиден
    final isValid = context.watch<ValidatePhoneCubit>().state;

    return BlocBuilder<PrivacyCheckCubit, ({bool user, bool marketing})>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) => BottomShadowWidget(
        child: AppTextButton.primary(
          text: !isLoading ? t.auth.getCode : null,
          onTap: isLoading
              ? null
              : isValid && state.user
                  ? () => onTapGetCode(context)
                  : null,
        ),
      ),
    );
  }
}
