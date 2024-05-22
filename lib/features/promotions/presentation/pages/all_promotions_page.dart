import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/features/promotions/presentation/cubit/promotions_cubit.dart';
import 'package:niagara_app/features/promotions/presentation/widgets/promotion_widget.dart';

@RoutePage()
class AllPromotionsPage extends StatelessWidget {
  const AllPromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PromotionsCubit, PromotionsState>(
        builder: (_, state) => state.maybeWhen(
          orElse: SizedBox.shrink,
          loaded: (promotions) => SingleChildScrollView(
            child: Column(
              children: [
                AppBoxes.kHeight48,
                ...List.generate(
                  promotions.length,
                  (index) => Padding(
                    padding: AppInsets.kVertical12,
                    child: PromotionWidget(
                      promotion: promotions[index],
                      withTitle: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
