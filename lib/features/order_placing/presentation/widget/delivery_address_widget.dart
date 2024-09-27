import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/locations/addresses/presentation/addresses/bloc/addresses_bloc.dart';

/// Виджет, отображающий адрес доставки.
///
/// Если адрес не указан или [editable] равен `true`, то можно перейти к выбору
/// адреса.
class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({
    super.key,
    this.editable = false,
  });

  /// Определяет возможность отредактировать адрес доставки.
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AddressesBloc>(),
      child: _Content(editable: editable),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.editable,
  });

  final bool editable;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AddressesBloc>();

    final state = bloc.state;
    final String? address = state.fullLocationName;
    final bool hasLocation = state.hasLocation && address != null;
    final bool hasAny = state.hasAnyLocation;

    /// Переход к добавлению адреса.
    void goToAddressAdding() => context.pushRoute(
          const LocationsWrapper(
            children: [
              AddingAddressWrapperRoute(
                children: [ChoiceOnMapRoute()],
              ),
            ],
          ),
        );

    void goToAddressEditing() => context.pushRoute(
          const LocationsWrapper(
            children: [
              LocationsTabRoute(children: [AddressesRoute()]),
            ],
          ),
        );

    return Padding(
      padding: AppInsets.kAll16 + AppInsets.kTop8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.orderPlacing.deliveryAddress,
                  style: context.textStyle.textTypo.tx1SemiBold,
                ),
                AppBoxes.kHeight8,
                if (hasLocation)
                  Text(
                    address,
                    style: context.textStyle.textTypo.tx2Medium,
                  )
                else
                  Text(
                    t.orderPlacing.selectDeliveryAddress,
                    style: context.textStyle.textTypo.tx2Medium.withColor(
                      context.colors.textColors.secondary,
                    ),
                  ),
              ],
            ),
          ),
          if (!hasLocation || editable)
            IconButton(
              onPressed: hasAny ? goToAddressEditing : goToAddressAdding,
              icon: Assets.icons.pen.svg(),
            ),
        ],
      ),
    );
  }
}
