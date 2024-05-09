import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/bonuses/presentation/widgets/benefits/benefit_builder_widget.dart';

class ListBenefitsWidget extends StatelessWidget {
  const ListBenefitsWidget({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // TODO(Oleg): Ожидание бэка
      children: [
        BenefitBuilderWidget(
          icon: Assets.icons.coinNiagara,
          title: '5 бонусов',
          description:
              'За каждую бутыль объемом от 12 до 19 литров',
        ),
        BenefitBuilderWidget(
          icon: Assets.icons.coinNiagara,
          title: '5 бонусов',
          description: 'За каждую бутыль объемом 5 литров',
        ),
        BenefitBuilderWidget(
          icon: Assets.icons.cashback,
          title: '3% бонусами',
          description:
              'При покупки любых товаров кроме воды объемом от 12 до 19 литров и тары',
        ),
      ],
    );
  }
}
