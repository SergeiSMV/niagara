import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/equipment/domain/model/equipment.dart';
import 'package:niagara_app/features/equipment/presentation/bloc/get_time_slots_cubit/get_time_slots_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<GetTimeSlotsCubit>()),
        ],
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
            const CleaningOrderButtonWidget(),
          ],
        ),
      ),
    );
  }
}
