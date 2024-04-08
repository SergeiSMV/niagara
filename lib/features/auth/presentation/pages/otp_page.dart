import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/auth/presentation/widgets/otp_code_widget.dart';
import 'package:niagara_app/features/auth/presentation/widgets/otp_title_widget.dart';
import 'package:niagara_app/features/auth/presentation/widgets/resend_code_widget.dart';

/// Страница для ввода кода подтверждения.
@RoutePage()
class OTPPage extends StatelessWidget {
  const OTPPage({
    required String phoneNumber,
    super.key,
  }) : _phoneNumber = phoneNumber;

  final String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: t.auth.confirmNumber),
      body: Column(
        children: [
          OTPTitleWidget(phoneNumber: _phoneNumber),
          const OTPCodeWidget(),
          const Spacer(),
          const ReSendCodeWidget(),
        ],
      ).paddingSymmetric(horizontal: AppConst.kPaddingMax),
    );
  }
}
