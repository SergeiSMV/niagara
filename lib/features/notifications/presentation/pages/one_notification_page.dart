import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_borders.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/notifications/domain/model/notification.dart';
import 'package:niagara_app/features/notifications/domain/model/notifications_types.dart';

@RoutePage()
class OneNotificationPage extends StatelessWidget {
  const OneNotificationPage({
    super.key,
    required this.notification,
  });

  final NotificationItem notification;

  void _goShopping(BuildContext context) {
    if (notification.type == NotificationsTypes.offers) {
      // context.navigateTo(const CategoryRoute());
      // context.router.pushNamed(CategoryRoute.name);
      context.router.popUntilRoot();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(automaticallyImplyTitle: false),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kHorizontal16,
              child: ClipRRect(
                borderRadius: AppBorders.kCircular16,
                child: ExtendedImage.network(
                  notification.image,
                  fit: BoxFit.cover,
                  loadStateChanged: (state) =>
                      state.extendedImageLoadState == LoadState.loading
                          ? const AppCenterLoader()
                          : null,
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
}
