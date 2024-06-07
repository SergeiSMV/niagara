import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/catalog/domain/model/group.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/products_bloc/products_bloc.dart';
import 'package:niagara_app/features/locations/cities/presentation/widgets/list_separator_widget.dart';

@RoutePage()
class FiltersPage extends StatelessWidget {
  const FiltersPage({
    super.key,
    required this.group,
  });

  final Group group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProductsBloc>(param1: group),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (_, state) => state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loaded: (_, filters) => Scaffold(
            body: CustomScrollView(
              slivers: [
                const SliverAppBarWidget(),
                SliverToBoxAdapter(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filters.length,
                    itemBuilder: (_, index) => Container(),
                    separatorBuilder: (_, __) => const ListSeparatorWidget(),
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
