import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/errors/error_refresh_widget.dart';
import 'package:niagara_app/core/common/presentation/widgets/loaders/app_center_loader.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/enums/policy_type.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/features/profile/about/presentation/bloc/policies_bloc.dart';

@RoutePage()
class PolicyPage extends StatelessWidget {
  const PolicyPage({
    super.key,
    required this.type,
  });

  final PolicyType type;

  void _load(BuildContext context) =>
      context.read<PoliciesBloc>().add(PoliciesEvent.getPolicy(type: type));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarWidget(
            body: _Title(type),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppInsets.kAll16,
              child: BlocProvider(
                create: (_) => getIt<PoliciesBloc>()
                  ..add(PoliciesEvent.getPolicy(type: type)),
                child: BlocBuilder<PoliciesBloc, PoliciesState>(
                  builder: (_, state) => state.maybeWhen(
                    loaded: (policy) => HtmlWidget(policy.html),
                    error: (msg) => ErrorRefreshWidget(
                      onRefresh: () => _load(context),
                    ),
                    orElse: AppCenterLoader.new,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.type);

  final PolicyType type;

  @override
  Widget build(BuildContext context) {
    final style = context.textStyle.textTypo.tx1SemiBold;
    return Column(
      children: [
        Text(
          type.titleFirstLine,
          style: style,
        ),
        Text(
          type.titleSecondLine,
          style: style,
        ),
      ],
    );
  }
}
