import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/bottom_shadow_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/extensions/widget_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/presentation/adding_address/address_details/cubit/address_details_cubit.dart';
import 'package:niagara_app/features/location/presentation/adding_address/address_details/widget/address_details_fields_widget.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';

@RoutePage()
class EditLocationPage extends StatelessWidget {
  const EditLocationPage({
    required Location location,
    super.key,
  }) : _location = location;

  final Location _location;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<AddressDetailsCubit>(param1: _location),
        child: Scaffold(
          appBar: AppBarWidget(
            actions: [if (!_location.isDefault) const _DeleteLocationWidget()],
          ),
          body: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      _location.name,
                      style: context.textStyle.textTypo.tx1SemiBold
                          .withColor(context.colors.textColors.main),
                    ).paddingAll(AppConst.kCommon16),
                  ),
                ],
              ),
              AddressDetailsFieldsWidget(location: _location)
                  .paddingAll(AppConst.kCommon16),
              const Spacer(),
            ],
          ),
          bottomNavigationBar: const _SaveChangesButton(),
        ),
      );
}

class _DeleteLocationWidget extends StatelessWidget {
  const _DeleteLocationWidget();

  void _onDelete(BuildContext context) {
    final location = context.read<AddressDetailsCubit>().state;
    context
      ..maybePop()
      ..read<LocationsBloc>().add(LocationsEvent.deleteLocation(location))
      ..navigateTo(const LocationsRoute());
  }

  void _showDeleteDialog(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        builder: (_) => Align(
          alignment: Alignment.bottomCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.colors.mainColors.white,
              borderRadius: BorderRadius.circular(
                AppConst.kCommon24 - AppConst.kCommon4,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.locations.deleteAddress,
                  style: context.textStyle.headingTypo.h3
                      .withColor(context.colors.textColors.main),
                ),
                AppConst.kCommon24.verticalBox,
                Material(
                  child: Row(
                    children: [
                      Expanded(
                        child: AppTextButton.secondary(
                          text: t.common.no,
                          onTap: () => context.maybePop(),
                        ),
                      ),
                      AppConst.kCommon12.horizontalBox,
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
            ).paddingSymmetric(
              vertical: AppConst.kCommon24,
              horizontal: AppConst.kCommon16,
            ),
          ),
        ).paddingAll(AppConst.kCommon8),
      );

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => _showDeleteDialog(context),
        child: Assets.icons.delete.svg(),
      ).padding(right: AppConst.kCommon16);
}

class _SaveChangesButton extends StatelessWidget {
  const _SaveChangesButton();

  VoidCallback? _onSave(BuildContext context) {
    final hasChanges = context.watch<AddressDetailsCubit>().hasChanges;
    if (!hasChanges) return null;

    return () {
      final location = context.read<AddressDetailsCubit>().state;
      context
        ..read<LocationsBloc>().add(LocationsEvent.updateLocation(location))
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
