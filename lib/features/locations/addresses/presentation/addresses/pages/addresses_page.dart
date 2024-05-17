import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/bottom_shadow_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/widgets/list_addresses_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/widgets/unauthorized_address_widget.dart';

@RoutePage()
class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  void _onRefresh(BuildContext context) =>
      context.read<AddressesBloc>().add(const AddressesEvent.loadAddresses());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AddressesBloc, AddressesState>(
        buildWhen: (prev, current) => prev != current,
        builder: (_, state) => state.when(
          initial: SizedBox.shrink,
          loading: () => const AppCenterLoader(),
          loaded: (_, addresses) => Column(
            children: [
              AppBoxes.kBoxV48,
              Expanded(
                child: ListAddressesWidget(
                  addresses: addresses.reversed.toList(),
                ),
              ),
              BottomShadowWidget(
                child: AppTextButton.primary(
                  text: t.common.save,
                  onTap: () => context.maybePop(),
                ),
              ),
            ],
          ),
          unauthorized: (_) => const UnauthorizedAddressWidget(),
          error: (_) => ErrorRefreshWidget(
            error: t.locations.errorLoad,
            onRefresh: () => _onRefresh(context),
          ),
        ),
      ),
    );
  }
}
