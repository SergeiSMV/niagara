import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/bottom_shadow_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/address_details/cubit/address_details_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/address_details/widget/address_details_fields_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/address_details/widget/editing_unavailable_banner.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';

@RoutePage()
class EditAddressPage extends StatelessWidget {
  const EditAddressPage({
    required Address address,
    super.key,
  }) : _address = address;

  final Address _address;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddressDetailsCubit>(param1: _address),
      child: Scaffold(
        appBar: const AppBarWidget(
          actions: [
            _DeleteLocationWidget(),
          ],
        ),
        body: Padding(
          padding: AppInsets.kHorizontal16,
          child: Column(
            children: [
              AppBoxes.kHeight16,
              Row(
                children: [
                  Flexible(
                    child: Text(
                      _address.name,
                      style: context.textStyle.textTypo.tx1SemiBold
                          .withColor(context.colors.textColors.main),
                    ),
                  ),
                ],
              ),
              AppBoxes.kHeight16,
              AddressDetailsFieldsWidget(location: _address),
              const Spacer(),
              if (_address.readOnly) ...[
                const EditingUnavailablebanner(),
                AppBoxes.kHeight12,
              ],
            ],
          ),
        ),
        bottomNavigationBar: const _SaveChangesButton(),
      ),
    );
  }
}

class _DeleteLocationWidget extends StatelessWidget {
  const _DeleteLocationWidget();

  void _onDelete(BuildContext context) {
    final location = context.read<AddressDetailsCubit>().state;
    context
      ..maybePop()
      ..read<AddressesBloc>().add(AddressesEvent.deleteAddress(location))
      ..navigateTo(const AddressesRoute());
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      useRootNavigator: false,
      builder: (_) => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: AppInsets.kAll8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.mainColors.white,
              borderRadius: BorderRadius.circular(
                AppSizes.kGeneral24 - AppSizes.kGeneral4,
              ),
            ),
            child: Padding(
              padding: AppInsets.kVertical24 + AppInsets.kHorizontal16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.locations.deleteAddress,
                    style: context.textStyle.headingTypo.h3
                        .withColor(context.colors.textColors.main),
                  ),
                  AppBoxes.kHeight24,
                  Material(
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextButton.secondary(
                            text: t.common.no,
                            onTap: () => context.maybePop(),
                          ),
                        ),
                        AppBoxes.kWidth12,
                        Expanded(
                          child: AppTextButton.primary(
                            text: t.common.yes,
                            onTap: () => _onDelete(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => _showDeleteDialog(context),
        child: Padding(
          padding: AppInsets.kRight16,
          child: Assets.icons.delete.svg(),
        ),
      );
}

class _SaveChangesButton extends StatelessWidget {
  const _SaveChangesButton();

  VoidCallback? _onSave(BuildContext context) {
    final hasChanges = context.watch<AddressDetailsCubit>().hasChanges;
    if (!hasChanges) return null;

    return () {
      final location = context.read<AddressDetailsCubit>().state;
      context
        ..read<AddressesBloc>().add(AddressesEvent.updateAddress(location))
        ..maybePop(location);
    };
  }

  @override
  Widget build(BuildContext context) => BottomShadowWidget(
        child: AppTextButton.accent(
          text: t.common.save,
          onTap: _onSave(context),
        ),
      );
}
