import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/address_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/cleaning_order_button_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/comment_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/equipment_widget.dart';
import 'package:niagara_app/features/equipment/presentation/widgets/cleaning_request_page_widgets/select_date_widget.dart';

/// Экран заказа чистки оборудования
@RoutePage()
class CleaningRequestPage extends StatelessWidget {
  const CleaningRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(),
          EquipmentWidget(
            imageUrl: '',
            equipmentName: 'Диспенсер Ecotronic K25-LCE black Marble',
          ),
          AddressWidget(),
          SelectDateWidget(),
          CommentWidget(),
          CleaningOrderButtonWidget(),
        ],
      ),
    );
  }
}
