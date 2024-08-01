import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

/// Кнопка "оформить подписку".
class VipSubcribeButton extends StatelessWidget {
  const VipSubcribeButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          AppInsets.kHorizontal16 + AppInsets.kVertical12 + AppInsets.kBottom12,
      child: AppTextButton.primary(
        text: t.vip.subscribe,
        // TODO: Навигация на страницу оформения покупки (сначала нужна Юкасса)
        onTap: () {},
      ),
    );
  }
}
