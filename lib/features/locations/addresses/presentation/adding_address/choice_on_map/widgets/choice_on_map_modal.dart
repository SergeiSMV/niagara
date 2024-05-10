import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/widgets/approve_address_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/widgets/complete_address_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/widgets/delivery_unavailable_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/widgets/location_unavailable_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/widgets/no_address_found_widget.dart';

class ChoiceOnMapModal extends StatelessWidget {
  const ChoiceOnMapModal({super.key});

  static const _minSize = AppConst.kCommon01;
  static const _maxSize = AppConst.kCommon05;
  static const _snapSize = AppConst.kCommon03;

  static final _sheetKey = GlobalKey();
  static final _controller = DraggableScrollableController();

  DraggableScrollableSheet get _sheet =>
      _sheetKey.currentWidget! as DraggableScrollableSheet;

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: Durations.short4,
      curve: Curves.easeInOut,
    );
  }

  void _min() => _animateSheet(_sheet.minChildSize);
  void _max() => _animateSheet(_sheet.maxChildSize);
  void _moveFirstSnap() => _animateSheet(_sheet.snapSizes!.first);
  void _moveLastSnap() => _animateSheet(_sheet.snapSizes!.last);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      listenWhen: (previous, current) => previous.finished != current.finished,
      listener: (_, state) => state.finished ? null : _min(),
      child: BlocConsumer<ChoiceOnMapCubit, ChoiceOnMapState>(
        listenWhen: (previous, current) => previous != current,
        listener: (_, state) => state.map(
          initial: (_) => null,
          complete: (_) => _moveFirstSnap(),
          approve: (_) => _max(),
          noAddressFound: (_) => _moveFirstSnap(),
          noDelivery: (_) => _moveLastSnap(),
          denied: (_) => _moveLastSnap,
        ),
        buildWhen: (previous, current) => previous != current,
        builder: (_, state) => DraggableScrollableSheet(
          key: _sheetKey,
          controller: _controller,
          initialChildSize: state.maybeWhen(
            noDelivery: (_) => _minSize + _minSize,
            denied: () => _minSize + _minSize,
            orElse: () => _minSize,
          ),
          maxChildSize: _maxSize,
          minChildSize: state.maybeWhen(
            noDelivery: (_) => _minSize + _minSize,
            denied: () => _minSize + _minSize,
            orElse: () => _minSize,
          ),
          snap: true,
          snapSizes: const [_snapSize, _snapSize + _minSize],
          shouldCloseOnMinExtent: false,
          builder: (_, scrollController) => Column(
            children: [
              state.maybeMap(
                noDelivery: (_) => const DeliveryUnavailableWidget(),
                denied: (_) => const LocationUnavailableWidget(),
                orElse: SizedBox.shrink,
              ),
              Expanded(
                child: ModalBackgroundWidget(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: AnimatedSwitcher(
                          duration: Durations.short3,
                          child: state.when(
                            initial: SizedBox.shrink,
                            complete: CompleteAddressWidget.new,
                            approve: ApproveAddressWidget.new,
                            denied: NoAddressFoundWidget.new,
                            noAddressFound: NoAddressFoundWidget.new,
                            noDelivery: CompleteAddressWidget.new,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
