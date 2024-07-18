import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/buttons/app_text_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/close_modal_button.dart';
import 'package:niagara_app/core/common/presentation/widgets/modals/draggable_pin_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/snack_bars/app_snack_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/app_text_field.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/order_history/domain/models/order_evaluation_option.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/evaluate_order_cubit/evaluate_order_cubit.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/order_evaluations_options_cubit/order_evaluations_options_cubit.dart';
import 'package:niagara_app/features/order_history/presentation/bloc/orders_bloc/orders_bloc.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/estimate_sent_modal_widget.dart';
import 'package:niagara_app/features/order_history/presentation/widgets/modals_widgets/list_options_widget.dart';

class EstimateModalWidget extends StatelessWidget {
  const EstimateModalWidget({
    super.key,
    required this.orderId,
  });

  final String orderId;

  Future<void> _onCloseModal(BuildContext context) async => context.maybePop();

  void _changeRating(BuildContext context, double rating) =>
      context.read<OrderEvaluationsOptionsCubit>().changeRating(rating);

  void _saveComment(BuildContext context, String comment) {
    context.read<OrderEvaluationsOptionsCubit>().comment = comment;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<OrderEvaluationsOptionsCubit>()..getOrderEvaluationsOptions(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<OrderEvaluationsOptionsCubit>();
          return Padding(
            padding: AppInsets.kHorizontal16 +
                EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PinWidget(),
                  AppBoxes.kHeight12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t.recentOrders.rateOrder,
                        style: context.textStyle.headingTypo.h3
                            .withColor(context.colors.textColors.main),
                      ),
                      CloseModalButton(onTap: () => _onCloseModal(context)),
                    ],
                  ),
                  AppBoxes.kHeight8,
                  Text(
                    t.recentOrders.generalAssessment,
                    style: context.textStyle.textTypo.tx1SemiBold
                        .withColor(context.colors.textColors.main),
                  ),
                  AppBoxes.kHeight12,
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    itemSize: 32,
                    itemPadding: AppInsets.kHorizontal6,
                    itemBuilder: (__, _) =>
                        Assets.images.ratingStarFilled.image(),
                    onRatingUpdate: (rating) => _changeRating(context, rating),
                  ),
                  AppBoxes.kHeight24,
                  const ListOptionsWidget(),
                  BlocBuilder<OrderEvaluationsOptionsCubit,
                      OrderEvaluationsOptionsState>(
                    builder: (context, state) {
                      final rating =
                          context.read<OrderEvaluationsOptionsCubit>().rating;
                      return Text(
                        rating == 5.0
                            ? t.recentOrders.generalImpressions
                            : t.recentOrders.otherOptions,
                        style: context.textStyle.textTypo.tx1SemiBold
                            .withColor(context.colors.textColors.main),
                      );
                    },
                  ),
                  AppBoxes.kHeight12,
                  AppTextField.text(
                    expandable: true,
                    label: t.recentOrders.yourComment,
                    onChanged: (val) => _saveComment(context, val ?? ''),
                  ),
                  AppBoxes.kHeight24,
                  _SendRating(
                    orderId: orderId,
                    rating: cubit.rating,
                    description: cubit.comment,
                    options: cubit.options,
                  ),
                  AppBoxes.kHeight32,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SendRating extends StatelessWidget {
  const _SendRating({
    required this.orderId,
    required this.rating,
    required this.description,
    required this.options,
  });

  final String orderId;
  final double rating;
  final String description;
  final List<OrderEvaluationOption> options;

  void _send(BuildContext context) {
    context.read<EvaluateOrderCubit>().estimate(
          id: orderId,
          rating: rating.toInt().toString(),
          description: description,
          optionsIds: options
              .where((option) => option.isSelected)
              .map((option) => option.id)
              .toList(),
        );
  }

  Future<void> _showEstimateSentModal(BuildContext context) async =>
      showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        useSafeArea: true,
        builder: (ctx) => const EstimateSentModalWidget(),
      );

  Future<void> _onCloseModal(BuildContext context) async => context.maybePop();

  void _evaluationOrderCompleted(
    BuildContext context,
    EvaluateOrderState state,
  ) {
    state.maybeWhen(
      error: () => AppSnackBar.showErrorShackBar(
        context,
        title: t.recentOrders.sendingError,
        subtitle: t.recentOrders.failedSendRating,
      ),
      success: () {
        _onCloseModal(context).then((_) => _showEstimateSentModal(context));
        // context.read<OrdersBloc>()
        getIt<OrdersBloc>().add(
          OrdersEvent.orderEvaluation(
            orderId: orderId,
            rating: rating.toInt(),
          ),
        );
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EvaluateOrderCubit>(),
      child: BlocBuilder<EvaluateOrderCubit, EvaluateOrderState>(
        builder: (context, state) {
          _evaluationOrderCompleted(context, state);

          final loading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return AppTextButton.primary(
            text: !loading ? t.recentOrders.send : null,
            onTap: () => _send(context),
          );
        },
      ),
    );
  }
}
