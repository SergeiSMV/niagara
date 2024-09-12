import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/vip/presentation/bloc/vip_description_bloc/vip_description_bloc.dart';
import 'package:niagara_app/features/vip/presentation/widget/activation_options_widget.dart';
import 'package:niagara_app/features/vip/presentation/widget/vip_benefits_list.dart';
import 'package:niagara_app/features/vip/presentation/widget/vip_subscribe_button.dart';

@RoutePage()
class VipPage extends StatelessWidget {
  const VipPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Обновление данных.
    void onRefresh() =>
        context.read<VipDescriptionBloc>().add(const VipEvent.started());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          SliverToBoxAdapter(
            child: Assets.images.vipUpperBanner.image(),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<VipDescriptionBloc, VipState>(
              builder: (context, state) => state.maybeWhen(
                loaded: _Content.new,
                loading: AppCenterLoader.new,
                error: () => ErrorRefreshWidget(onRefresh: onRefresh),
                orElse: SizedBox.shrink,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const VipSubcribeButton(),
    );
  }
}

/// Содержание страницы.
class _Content extends StatelessWidget {
  const _Content(this.description, this.vipEndDate);

  final StatusDescription description;
  final String? vipEndDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical32,
      child: Column(
        children: [
          VipBenefitsList(description.benefits),
          AppBoxes.kHeight32,
          if (description.activationOptions != null)
            ActivationOptionsWidget(description.activationOptions!, vipEndDate),
        ],
      ),
    );
  }
}
