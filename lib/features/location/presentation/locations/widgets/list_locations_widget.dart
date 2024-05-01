import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/location/domain/models/location.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';
import 'package:niagara_app/features/location/presentation/locations/widgets/add_new_location_button.dart';

class ListLocationsWidget extends StatelessWidget {
  const ListLocationsWidget({
    required this.locations,
    super.key,
  });

  final List<Location> locations;

  void _onEditLocation(BuildContext context, Location location) =>
      context.pushRoute(EditLocationRoute(location: location));

  void _onSetDefault(BuildContext context, Location location) =>
      location.isDefault
          ? null
          : context
              .read<LocationsBloc>()
              .add(LocationsEvent.setDefaultLocation(location));

  SvgGenImage _buildRadioIcon(BuildContext context, Location location) =>
      location.isDefault
          ? Assets.icons.radio.radioTrue
          : Assets.icons.radio.radioFalse;

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: AppConst.kCommon12.vertical,
        itemCount: locations.length + 1,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          if (index == locations.length) {
            return const AddNewLocationButton();
          }

          final location = locations[index];
          return ListTile(
            contentPadding: AppConst.kCommon16.horizontal,
            leading: _buildRadioIcon(context, location).svg(
              width: AppConst.kIconMedium,
              height: AppConst.kIconMedium,
            ),
            title: Text(
              location.name,
              style: context.textStyle.textTypo.tx1Medium
                  .withColor(context.colors.textColors.main),
            ),
            subtitle: location.hasDetails
                ? Text(
                    location.additional,
                    style: context.textStyle.descriptionTypo.des3
                        .withColor(context.colors.textColors.secondary),
                  )
                : null,
            trailing: InkWell(
              onTap: () => _onEditLocation(context, location),
              child: Assets.icons.pen.svg(
                width: AppConst.kIconMedium,
                height: AppConst.kIconMedium,
              ),
            ),
            onTap: () => _onSetDefault(context, location),
          ); // выбор
        },
      );
}
