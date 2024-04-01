import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:niagara_app/features/auth/presentation/widgets/auth_later_button.dart';
import 'package:niagara_app/features/auth/presentation/widgets/enter_phone_widget.dart';
import 'package:niagara_app/features/auth/presentation/widgets/get_code_widget.dart';
import 'package:niagara_app/features/auth/presentation/widgets/phone_number_field.dart';
import 'package:niagara_app/features/auth/presentation/widgets/privacy_policy_text_button.dart';

/// Страница авторизации [AuthPage] с вводом номера телефона и кнопкой
/// "Получить код", а также ссылками на политику конфиденциальности.
@RoutePage()
class AuthPage extends StatelessWidget {
  /// Конструктор страницы авторизации [AuthPage].
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    void navigateToMain() => context.replaceRoute(const NavigationRoute());

    void navigateToOTP(String phone) =>
        context.pushRoute(OTPRoute(phoneNumber: phone));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const EnterPhoneWidget(),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (_, state) => state.maybeWhen(
          getCode: navigateToOTP,
          authLater: navigateToMain,
          orElse: () => null,
        ),
        child: Column(
          children: [
            PhoneNumberField(formKey: formKey),
            const AuthLaterButton(),
            const Spacer(),
            const PrivacyPolicyTextButtons(),
            AppConst.kAuthPrivacyPolicyBottomOffset.height,
            GetCodeWidget(formKey: formKey),
          ],
        ),
      ),
    );
  }
}
