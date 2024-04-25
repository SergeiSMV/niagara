import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/static_bottom_modal.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/location/presentation/address_selection/cubit/address_selection_cubit.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/approve_address_widget.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/complete_address_widget.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/location_unavailable_widget.dart';
import 'package:niagara_app/features/location/presentation/address_selection/widgets/no_address_found_widget.dart';

class AddressSelectionModal extends StatelessWidget {
  const AddressSelectionModal({super.key});

  static Duration get _duration => Durations.short2;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressSelectionCubit, AddressSelectionState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => AnimatedSwitcher(
        duration: _duration,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Stack(
          key: ValueKey(state),
          fit: StackFit.expand,
          children: [
            state.maybeWhen(
              approve: (_) => DecoratedBox(
                decoration: BoxDecoration(
                  color: context.colors.otherColors.background70,
                ),
              ),
              orElse: SizedBox.shrink,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                state.maybeWhen(
                  denied: LocationUnavailableWidget.new,
                  orElse: SizedBox.shrink,
                ),
                StaticBottomModalWidget(
                  child: AnimatedSize(
                    duration: _duration,
                    child: SafeArea(
                      child: state.maybeWhen(
                        complete: CompleteAddressWidget.new,
                        approve: ApproveAddressWidget.new,
                        denied: NoAddressFoundWidget.new,
                        noAddressFound: NoAddressFoundWidget.new,
                        orElse: () => const SizedBox(
                          width: double.infinity,
                          height: AppConst.kCommon16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
