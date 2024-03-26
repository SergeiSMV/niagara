import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Кнопка "Получить код" для отправки кода подтверждения на номер телефона.
class GetCodeWidget extends StatelessWidget {
  /// Создает экземпляр [GetCodeWidget].
  const GetCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConst.kPaddingMax),
      decoration: BoxDecoration(
        color: context.colors.mainColors.white,
        boxShadow: [
          BoxShadow(
            color: context.colors.textColors.main
                .withOpacity(AppConst.kShadowOpacity),
            offset: AppConst.kShadowOffset,
            blurRadius: AppConst.kShadowBlur,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(
          top: AppConst.kGetCodeButtonTopPadding,
          bottom: AppConst.kGetCodeButtonBottomPadding,
        ),
        maintainBottomViewPadding: true,
        child: AppTextButton.primary(
          context,
          text: t.auth.getCode,
          onTap: () {},
        ),
      ),
    );
  }
}
