import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/dependencies/di.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/catalog_search_bloc/catalog_search_bloc.dart';
import 'package:niagara_app/features/catalog/presentation/widget/search/catalog_search_content_widget.dart';

@RoutePage()
class CatalogSearchPage extends StatelessWidget {
  const CatalogSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<CatalogSearchBloc>(),
        child: const CatalogSearchContentWidget(),
      ),
    );
  }
}
