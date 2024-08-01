import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/editing/presentation/bloc/email_confirmation_bloc/email_confirmation_bloc.dart';

class EnterEmailForm extends StatefulWidget {
  const EnterEmailForm({this.initialEmail});

  final String? initialEmail;

  @override
  State<EnterEmailForm> createState() => _EnterEmailFormState();
}

class _EnterEmailFormState extends State<EnterEmailForm> {
  String? email;

  void _setEmail(String? email) => setState(() => this.email = email);

  void _onConfirm() => context.read<EmailConfirmationBloc>().add(
        EmailConfirmationEvent.createCode(email: email!),
      );

  @override
  void initState() {
    super.initState();
    email = widget.initialEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.profile.edit.enterEmail,
              style: context.textStyle.headingTypo.h3,
            ),
            InkWell(
              onTap: () => context.maybePop(),
              child: Assets.icons.close.svg(
                width: AppSizes.kIconLarge,
                height: AppSizes.kIconLarge,
              ),
            ),
          ],
        ),
        AppBoxes.kHeight24,
        AppTextField.email(
          initialText: email,
          onChanged: _setEmail,
        ),
        AppBoxes.kHeight16,
        AppTextButton.accent(
          text: t.profile.edit.confirm,
          onTap: email != null ? _onConfirm : null,
        ),
      ],
    );
  }
}
