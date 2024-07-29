import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/enums/base_text_filed_state.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: AppInsets.kHorizontal16,
                child: Column(
                  children: [
                    AppBoxes.kHeight24,
                    AppTextField.text(
                      hint: t.profile.edit.name,
                      showCounter: true,
                      isRequired: true,
                    ),
                    AppBoxes.kHeight12,
                    AppTextField.text(
                      hint: t.profile.edit.surname,
                      isRequired: true,
                    ),
                    AppBoxes.kHeight12,
                    AppTextField.text(
                      hint: t.profile.edit.paternalName,
                    ),
                    AppBoxes.kHeight12,
                    AppTextField.phone(
                      initialText: '9630983032',
                      state: BaseTextFieldState.disabled,
                    ),
                    AppBoxes.kHeight12,
                    AppTextField.text(
                      hint: t.profile.edit.email,
                      isRequired: true,
                    ),
                    AppBoxes.kHeight24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          t.profile.edit.birthday,
                          style: context.textStyle.textTypo.tx1Medium,
                        ),
                        Assets.icons.arrowRight.svg(),
                      ],
                    ),
                    AppBoxes.kHeight16,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.images.gift.image(
                          width: AppSizes.kGeneral48,
                          height: AppSizes.kGeneral40,
                        ),
                        AppBoxes.kWidth12,
                        Expanded(
                          child: Text(
                            t.profile.edit.birthdayDescription,
                            style:
                                context.textStyle.textTypo.tx2Medium.withColor(
                              context.colors.textColors.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
