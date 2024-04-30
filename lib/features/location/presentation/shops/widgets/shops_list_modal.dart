import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/num_ext.dart';
import 'package:niagara_app/features/location/presentation/shops/bloc/shops_bloc.dart';

class ShopsListModal extends StatelessWidget {
  const ShopsListModal({super.key});

  static const _minSize = .15;
  static const _maxSize = .97;
  static const _snapSize = .45;

  static final _sheetKey = GlobalKey();
  static final _controller = DraggableScrollableController();

  DraggableScrollableSheet get _sheet =>
      _sheetKey.currentWidget! as DraggableScrollableSheet;

  void _anchor() => _animateSheet(_sheet.snapSizes!.last);

  void _hide() => _animateSheet(_sheet.minChildSize);

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
      listener: (_, state) => state.finished ? _anchor() : _hide(),
      child: BlocBuilder<ShopsBloc, ShopsState>(
        buildWhen: (previous, current) => previous != current,
        builder: (_, state) => state.maybeWhen(
          orElse: SizedBox.shrink,
          loaded: (shops) => DraggableScrollableSheet(
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
                  const SliverPersistentHeader(delegate: DraggablePinWidget()),
                  SliverList.builder(
                    itemCount: shops.length + 1,
                    itemBuilder: (context, index) {
                      if (index == shops.length) {
                        return AppConst.kCommon16.verticalBox;
                      }

                      final shop = shops[index];
                      return ListTile(
                        title: Text(shop.name),
                        subtitle: Text(shop.coordinates.toString()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
