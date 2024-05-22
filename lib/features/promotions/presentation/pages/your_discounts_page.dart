import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';

@RoutePage()
class YourDiscountsPage extends StatelessWidget {
  const YourDiscountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppInsets.kAll16,
        child: Row(
          children: [
            Flexible(
              child: Text(
                'Персонализированные скидки еще в разработке и появятся в будущих версиях приложения.',
                style: context.textStyle.textTypo.tx2Medium
                    .withColor(context.colors.textColors.main),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
