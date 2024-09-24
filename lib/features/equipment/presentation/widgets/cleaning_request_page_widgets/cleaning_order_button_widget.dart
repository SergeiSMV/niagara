import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/order_cleaning_equipment_cubit/order_cleaning_equipment_cubit.dart';

class CleaningOrderButtonWidget extends StatelessWidget {
  const CleaningOrderButtonWidget({
    super.key,
    required this.locationId,
    required this.deviceId,
  });

  final String locationId;
  final int deviceId;

  void _orderCleaning(BuildContext context) =>
      context.read<OrderCleaningEquipmentCubit>().orderCleaning(
            locationId: locationId,
            deviceId: deviceId,
          );

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: AppInsets.kAll16,
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          boxShadow: [
            BoxShadow(
              color: context.colors.textColors.main
                  .withOpacity(AppSizes.kShadowOpacity),
              offset: AppConstants.kShadowTop,
              blurRadius: AppSizes.kGeneral12,
            ),
          ],
        ),
        child: AppTextButton.primary(
          text: t.equipments.orderCleaning,
          onTap: () => _orderCleaning(context),
        ),
      ),
    );
  }
}
