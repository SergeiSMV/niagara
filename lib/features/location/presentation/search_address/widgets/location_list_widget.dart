import 'package:flutter/material.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/features/location/domain/entities/locality.dart';

class LocationListWidget extends StatelessWidget {
  const LocationListWidget(
    this.locations, {
    super.key,
  });

  final List<Location> locations;

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
          onTap: () {},
        );
      },
    );
  }
}
