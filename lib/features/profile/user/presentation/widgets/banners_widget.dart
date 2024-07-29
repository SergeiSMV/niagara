import 'package:flutter/material.dart';
import 'package:niagara_app/core/common/presentation/router/app_router.gr.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/profile/user/presentation/widgets/banner_widget.dart';

class BannersWidget extends StatelessWidget {
  const BannersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Градиенты, используемые в баннерах.
    final LinearGradient referralGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: context.colors.gradientColors.referralBanner,
      stops: AppConstants.profileBannersStops,
    );

    final LinearGradient promotionsGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: context.colors.gradientColors.promotionsBanner,
      stops: AppConstants.profileBannersStops,
    );

    final LinearGradient vipGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: context.colors.gradientColors.vipBanner,
      stops: AppConstants.profileBannersStops,
    );

    return Padding(
      padding: AppInsets.kVertical12 + AppInsets.kHorizontal16,
      child: Column(
        children: [
          BannerWidget(
            redirectRoute: const ReferralRoute(),
            gradient: referralGradient,
            title: t.profile.banners.referralHeader,
            description: t.profile.banners.referralDescription,
            image: Assets.images.referralBannerImage,
            bottomPositioning: -25,
            rightPositioning: -27,
          ),
          AppBoxes.kHeight12,
          BannerWidget(
            redirectRoute: const PromotionsTabRoute(),
            gradient: promotionsGradient,
            title: t.profile.banners.promotionsHeader,
            description: t.profile.banners.promotionsDescription,
            image: Assets.images.promotionsBannerImage,
            bottomPositioning: -25,
            rightPositioning: -15,
          ),
          AppBoxes.kHeight12,
          BannerWidget(
            onTap: () {},
            gradient: vipGradient,
            title: t.profile.banners.vipHeader,
            description: t.profile.banners.vipDescription,
            image: Assets.images.vIPBannerImage,
            bottomPositioning: -25,
            rightPositioning: -25,
          ),
        ],
      ),
    );
  }
}
