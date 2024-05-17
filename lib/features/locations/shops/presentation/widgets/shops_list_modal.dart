import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/modal_background_widget.dart';
import 'package:niagara_app/features/locations/_common/presentation/pages/map_yandex/cubit/map_cubit.dart';
import 'package:niagara_app/features/locations/shops/presentation/bloc/shops_bloc.dart';
import 'package:niagara_app/features/locations/shops/presentation/widgets/selected_shop_widget.dart';
import 'package:niagara_app/features/locations/shops/presentation/widgets/shops_list_widget.dart';

class ShopsListModal extends StatelessWidget {
  const ShopsListModal({super.key});

  static const _minSize = .1;
  static const _maxSize = .75;
  static const _snapSize = .4;

  static final _sheetKey = GlobalKey();
  static final _controller = DraggableScrollableController();

  DraggableScrollableSheet get _sheet =>
      _sheetKey.currentWidget! as DraggableScrollableSheet;

  void _anchor() => _animateSheet(_sheet.snapSizes!.first);

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
      listenWhen: (prev, curr) => prev.finished != curr.finished,
      listener: (_, state) => state.finished ? _anchor() : _hide(),
      child: BlocBuilder<ShopsBloc, ShopsState>(
        buildWhen: (prev, curr) => prev != curr,
        builder: (_, state) => DraggableScrollableSheet(
          key: _sheetKey,
          controller: _controller,
          initialChildSize: _minSize,
          maxChildSize: state.maybeMap(
            loaded: (_) => _maxSize,
            orElse: () => _snapSize,
          ),
          minChildSize: _minSize,
          snap: true,
          snapSizes: const [_snapSize],
          builder: (_, scrollCtrl) => ModalBackgroundWidget(
            child: CustomScrollView(
              controller: scrollCtrl,
              slivers: [
                const DraggablePinWidget(),
                BlocBuilder<ShopsBloc, ShopsState>(
                  buildWhen: (prev, curr) => prev != curr,
                  builder: (_, state) => state.maybeWhen(
                    loaded: (shops) => ShopsListWidget(shops: shops),
                    selectShop: (shop, _) => SelectedShopWidget(shop: shop),
                    orElse: () => const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
