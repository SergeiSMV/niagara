import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/bloc/date_selection_cubit/date_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/bloc/time_slot_selection_cubit/time_slot_selection_cubit.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/equipment/domain/model/equipment.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/get_dates_cubit/get_dates_cubit.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/get_time_slots_cubit/get_time_slots_cubit.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/order_cleaning_equipment_cubit/order_cleaning_equipment_cubit.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/address_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/cleaning_order_button_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/comment_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/equipment_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/select_date_widget.dart';

/// Экран заказа чистки оборудования
@RoutePage()
class CleaningRequestPage extends StatelessWidget {
  const CleaningRequestPage({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  void listenerOrderCleaningCubit(
    BuildContext context,
    OrderCleaningEquipmentState state,
  ) =>
      state.maybeWhen(
        validateData: () => AppSnackBar.showError(
          context,
          title: context.t.equipments.selectCleaningDate,
          barColor: context.colors.mainColors.bgCard,
        ),
        error: () => AppSnackBar.showError(
          context,
          title: context.t.equipments.anErrorHasOccurred,
        ),
        success: () => context.navigateTo(const CleaningOrderSuccessfulRoute()),
        orElse: () => null,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<OrderCleaningEquipmentCubit>()),
          BlocProvider(
            create: (_) =>
                getIt<GetDatesCubit>()..getDates(equipment.locationId),
          ),
          BlocProvider(create: (_) => getIt<GetTimeSlotsCubit>()),
          BlocProvider(create: (_) => getIt<TimeSlotSelectionCubit>()),
          BlocProvider(create: (_) => getIt<DateSelectionCubit>()),
        ],
        child: BlocListener<OrderCleaningEquipmentCubit,
            OrderCleaningEquipmentState>(
          listener: listenerOrderCleaningCubit,
          child: CustomScrollView(
            slivers: [
              const SliverAppBarWidget(),
              EquipmentWidget(
                imageUrl: equipment.imageUrl,
                equipmentName: equipment.name,
              ),
              AddressWidget(address: equipment.locationName),
              SelectDateWidget(locationId: equipment.locationId),
              const CommentWidget(),
              CleaningOrderButtonWidget(
                locationId: equipment.locationId,
                deviceId: equipment.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
