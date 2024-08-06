import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/features/profile/bonuses/domain/models/status_description.dart';
import 'package:niagara_app/features/vip/presentation/bloc/vip_bloc.dart';
import 'package:niagara_app/features/vip/presentation/widget/activation_options_widget.dart';
import 'package:niagara_app/features/vip/presentation/widget/vip_benefits_list.dart';
import 'package:niagara_app/features/vip/presentation/widget/vip_subscribe_button.dart';

@RoutePage()
class VipPage extends StatelessWidget {
  const VipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          SliverToBoxAdapter(
            child: Assets.images.vipUpperBanner.image(),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<VipBloc, VipState>(
              builder: (_, state) => state.maybeWhen(
                loaded: _Content.new,
                loading: AppCenterLoader.new,
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
  const _Content(this.description);

  final StatusDescription description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kHorizontal16 + AppInsets.kVertical32,
      child: Column(
        children: [
          VipBenefitsList(description.benefits),
          AppBoxes.kHeight32,
          ActivationOptionsWidget(description.activationOptions),
        ],
      ),
    );
  }
}
