import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/location/presentation/shops/bloc/shops_bloc.dart';
import 'package:niagara_app/features/location/presentation/shops/widgets/shops_list_modal.dart';
import 'package:niagara_app/features/location/presentation/shops/widgets/shops_map_widget.dart';

@RoutePage()
class ShopsPage extends StatelessWidget {
  const ShopsPage({super.key});

  void _onRefresh(BuildContext context) =>
      context.read<ShopsBloc>().add(const ShopsEvent.loading());

  @override
  Widget build(BuildContext context) => BlocBuilder<ShopsBloc, ShopsState>(
        builder: (_, state) => state.maybeWhen(
          loading: AppCenterLoader.new,
          error: (_) => ErrorRefreshWidget(
            error: t.shops.errorLoad,
            onRefresh: () => _onRefresh(context),
          ),
          orElse: () => const Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ShopsMapWidget(),
              ShopsListModal(),
            ],
          ),
        ),
      );
}
