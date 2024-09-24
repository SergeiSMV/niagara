import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_cards/product_in_cart.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/cart_product_data_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/cart_product_image_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/widget_components/slide_buttons_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

/// Развёрнутая горизонтально карточка товвара с кнопками `+` и `-`.
///
/// Используется для отображения в корзине и для преобретения предоплатной воды.
///
/// Используется вместе с [BlocProvider], который предоставит [product],
/// [count], [onAdd] и [onRemove].
///
/// Для примера см. [ProductInCart].
class BaseProductCartWidget extends StatefulWidget {
  const BaseProductCartWidget({
    super.key,
    required this.product,
    required this.onAdd,
    required this.onRemove,
    required this.count,
    this.isAvailable = true,
    this.interactive = true,
  });

  /// Преобретаемый товар.
  final Product product;

  /// Доступен ли товар для покупки.
  final bool isAvailable;

  /// Обработчик нажатия на кнопку увеличения количества товара.
  final VoidCallback onAdd;

  /// Обработчик нажатия на кнопку уменьшения количества товара.
  final VoidCallback onRemove;

  /// Количество товара.
  final int count;

  /// Возможно ли взаимодействие с виджетом.
  ///
  /// `false` отключает переход на страницу товара, [Slidable] функционал,
  /// кнопки `+` и `-`, а также немного изменяет внешний вид карточки.
  final bool interactive;

  @override
  State<BaseProductCartWidget> createState() => _BaseProductCartWidgetState();
}

class _BaseProductCartWidgetState extends State<BaseProductCartWidget>
    with SingleTickerProviderStateMixin {
  late final SlidableController slidableController;

  @override
  void initState() {
    super.initState();

    slidableController = SlidableController(this);
  }

  @override
  void dispose() {
    slidableController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget productCard = _CardContent(
      product: widget.product,
      slidableController: slidableController,
      interactive: widget.interactive,
      isAvailable: widget.isAvailable,
      onAdd: widget.onAdd,
      onRemove: widget.onRemove,
      count: widget.count,
    );

    if (!widget.interactive) return productCard;

    return Slidable(
      controller: slidableController,
      endActionPane: ActionPane(
        extentRatio: AppConstants.slideExtentRatio,
        motion: const ScrollMotion(),
        children: [
          SlideButtonsWidget(
            product: widget.product,
            onActionCompleted: () => slidableController.close(),
            onRemove: widget.onRemove,
          ),
        ],
      ),
      child: productCard,
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required this.product,
    required this.slidableController,
    required this.interactive,
    required this.isAvailable,
    required this.onAdd,
    required this.onRemove,
    required this.count,
  });

  final Product product;
  final SlidableController slidableController;
  final bool interactive;
  final bool isAvailable;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int count;

  @override
  Widget build(BuildContext context) {
    /// Переход на страницу товара.
    void goToProductPage() => context.navigateTo(
          CatalogWrapper(
            children: [
              ProductRoute(
                key: ValueKey(product.id),
                product: product,
              ),
            ],
          ),
        );

    return InkWell(
      onTap: interactive ? goToProductPage : null,
      child: Padding(
        padding: AppInsets.kVertical4,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.mainColors.bgCard,
            borderRadius: AppBorders.kCircular12,
          ),
          child: Padding(
            padding: AppInsets.kAll8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CartProductImageWidget(product: product),
                AppBoxes.kWidth12,
                CartProductDataWidget(
                  product: product,
                  isAvailable: isAvailable,
                  openSlideMenu: () => slidableController.openEndActionPane(),
                  onPlus: onAdd,
                  onMinus: onRemove,
                  count: count,
                  interactive: interactive,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
