import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/addresses/domain/models/address.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';
import 'package:yandex_mapkit_lite/yandex_mapkit_lite.dart';

class LocationListWidget extends StatelessWidget {
  const LocationListWidget(
    this.locations, {
    super.key,
  });

  final List<Address> locations;

  void _onTap(BuildContext context, Address location) {
    final mapCubit = context.read<MapCubit>();
    final choiceOnMapCubit = context.read<ChoiceOnMapCubit>();

    final point = Point(
      latitude: location.coordinates.$1,
      longitude: location.coordinates.$2,
    );

    context.navigateTo(const ChoiceOnMapRoute());

    mapCubit.moveCameraToPoint(point: point).whenComplete(
          () => choiceOnMapCubit.searchAddress(
            point: point,
            finished: true,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final textColors = context.colors.textColors;
    final textStyle = context.textStyle;
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return ListTile(
          title: Text(
            location.name,
            style: textStyle.textTypo.tx1Medium.withColor(textColors.main),
          ),
          subtitle: Text(
            location.description,
            style:
                textStyle.descriptionTypo.des3.withColor(textColors.secondary),
          ),
          onTap: () => _onTap(context, location),
        );
      },
    );
  }
}
