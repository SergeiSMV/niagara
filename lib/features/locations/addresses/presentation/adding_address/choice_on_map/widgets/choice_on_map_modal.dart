import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/cubit/choice_on_map_cubit.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/widgets/approve_address_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/widgets/complete_address_widget.dart';
import 'package:niagara_app/features/locations/addresses/presentation/adding_address/choice_on_map/widgets/no_address_found_widget.dart';

class ChoiceOnMapModal extends StatelessWidget {
  const ChoiceOnMapModal({super.key});

  static const _minSize = .1;
  static const _maxSize = .5;
  static const _snapSize = .3;

  static final _sheetKey = GlobalKey();
  static final _controller = DraggableScrollableController();

  DraggableScrollableSheet get _sheet =>
      _sheetKey.currentWidget! as DraggableScrollableSheet;

  void _middle() => _animateSheet(_sheet.snapSizes!.first);

  void _max() => _animateSheet(_sheet.maxChildSize);

  void _min() => _animateSheet(_sheet.minChildSize);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: Durations.short4,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapCubit, MapState>(
      listenWhen: (previous, current) => previous.finished != current.finished,
      listener: (_, state) => state.finished ? null : _min(),
      child: LayoutBuilder(
        builder: (_, constraints) {
          return DraggableScrollableSheet(
            key: _sheetKey,
            controller: _controller,
            initialChildSize: _minSize,
            maxChildSize: _maxSize,
            minChildSize: _minSize,
            snap: true,
            snapSizes: const [_snapSize],
            builder: (_, scrollController) => ModalBackgroundWidget(
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: BlocConsumer<ChoiceOnMapCubit, ChoiceOnMapState>(
                      listenWhen: (previous, current) => previous != current,
                      listener: (_, state) {
                        state.maybeWhen(
                          complete: (_) => _middle(),
                          approve: (_) => _max(),
                          noAddressFound: _middle,
                          orElse: () {},
                        );
                      },
                      buildWhen: (previous, current) => previous != current,
                      builder: (_, state) => AnimatedSwitcher(
                        duration: Durations.short3,
                        child: state.when(
                          initial: SizedBox.shrink,
                          complete: CompleteAddressWidget.new,
                          approve: ApproveAddressWidget.new,
                          denied: NoAddressFoundWidget.new,
                          noAddressFound: NoAddressFoundWidget.new,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
