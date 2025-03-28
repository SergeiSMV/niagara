import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/presentation/widgets/app_bar.dart';
import '../../../../core/common/presentation/widgets/app_network_image_widget.dart';
import '../../../../core/common/presentation/widgets/buttons/app_text_button.dart';
import '../../../../core/utils/constants/app_borders.dart';
import '../../../../core/utils/constants/app_boxes.dart';
import '../../../../core/utils/constants/app_insets.dart';
import '../../../../core/utils/extensions/build_context_ext.dart';
import '../../../../core/utils/extensions/text_style_ext.dart';
import '../../../../core/utils/gen/strings.g.dart';
import '../../domain/model/notification.dart';
import '../../domain/model/notifications_types.dart';

/// Страница одного уведомления.
@RoutePage()
class OneNotificationPage extends StatelessWidget {
  const OneNotificationPage({
    required this.notification,
    super.key,
  });

  /// Уведомление.
  final NotificationItem notification;

  /// Метод для перехода в магазин.
  void _goShopping(BuildContext context) {
    if (notification.type == NotificationsTypes.offers) {
      context.tabsRouter.setActiveIndex(1);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBarWidget(automaticallyImplyTitle: false),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppInsets.kHorizontal16,
                child: ClipRRect(
                  borderRadius: AppBorders.kCircular16,
                  child: AppNetworkImageWidget(
                    url: notification.image,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: AppBoxes.kHeight24),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppInsets.kHorizontal16,
                child: Text(
                  notification.title,
                  style: context.textStyle.headingTypo.h3.withColor(
                    context.colors.textColors.main,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: AppBoxes.kHeight12),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppInsets.kHorizontal16,
                child: Text(
                  notification.description,
                  style: context.textStyle.textTypo.tx2Medium.withColor(
                    context.colors.textColors.main,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: AppBoxes.kHeight24),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppInsets.kHorizontal16,
                child: AppTextButton.primary(
                  text: t.favorites.goShopping,
                  onTap: () => _goShopping(context),
                ),
              ),
            ),
          ],
        ),
      );
}
