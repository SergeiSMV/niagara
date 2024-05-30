import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/common/domain/models/product.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_expandable_properties_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/product/product_expandable_text_widget.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/iterable_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class ProductDescriptionWithPropertiesWidget extends HookWidget {
  const ProductDescriptionWithPropertiesWidget({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(0);

    final tabs = {
      t.catalog.description: ProductExpandableTextWidget(
        text: product.descriptionFull,
      ),
      t.catalog.properties: ProductExpandablePropertiesWidget(
        properties: product.properties,
      ),
    };

    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.mainColors.white,
          borderRadius: AppBorders.kCircular16 + AppBorders.kCircular2,
        ),
        child: Padding(
          padding: AppInsets.kAll16,
          child: product.properties.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      children: tabs.entries
                          .mapIndexed(
                            (i, e) => Row(
                              children: [
                                _TabButton(
                                  title: e.key,
                                  isSelected: selectedTab.value == i,
                                  onTap: () => selectedTab.value = i,
                                ),
                                if (i < tabs.length - 1) AppBoxes.kWidth12,
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    AppBoxes.kHeight12,
                    AnimatedSwitcher(
                      duration: Durations.medium1,
                      transitionBuilder: (child, animation) => SlideTransition(
                        position: animation.drive(
                          Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: child,
                      ),
                      child: IndexedStack(
                        key: ValueKey(selectedTab.value),
                        index: selectedTab.value,
                        children: tabs.entries.map((e) => e.value).toList(),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.catalog.description,
                      style: context.textStyle.textTypo.tx1SemiBold
                          .withColor(context.colors.textColors.main),
                    ),
                    AppBoxes.kHeight12,
                    ProductExpandableTextWidget(text: product.descriptionFull),
                  ],
                ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.mainColors.accent
              : context.colors.mainColors.bgCard,
          borderRadius: AppBorders.kCircular6,
        ),
        child: Padding(
          padding: AppInsets.kHorizontal12 + AppInsets.kVertical8,
          child: Text(
            title,
            style: context.textStyle.textTypo.tx2Medium.withColor(
              isSelected
                  ? context.colors.textColors.white
                  : context.colors.textColors.main,
            ),
          ),
        ),
      ),
    );
  }
}
