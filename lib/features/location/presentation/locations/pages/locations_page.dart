import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/bottom_shadow_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/locations/bloc/locations_bloc.dart';
import 'package:niagara_app/features/location/presentation/locations/widgets/list_locations_widget.dart';

@RoutePage()
class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  void _onRefresh(BuildContext context) =>
      context.read<LocationsBloc>().add(const LocationsEvent.loadLocations());

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LocationsBloc, LocationsState>(
        builder: (_, state) => state.when(
          initial: SizedBox.shrink,
          loading: () => const AppCenterLoader(),
          loaded: (_, locations) => Column(
            children: [
              Expanded(child: ListLocationsWidget(locations: locations)),
              BottomShadowWidget(
                child: AppTextButton.primary(
                  text: t.common.save,
                  onTap: () => context.pushRoute(const ChoiceOnMapRoute()),
                ),
              ),
            ],
          ),
          error: (_) => ErrorRefreshWidget(
            error: t.locations.errorLoad,
            onRefresh: () => _onRefresh(context),
          ),
        ),
      );
}
