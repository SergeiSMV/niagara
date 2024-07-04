import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/search_text_field.dart';
import 'package:niagara_app/core/utils/constants/app_boxes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/extensions/text_style_ext.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';
import 'package:niagara_app/features/catalog/presentation/bloc/catalog_search_bloc/catalog_search_bloc.dart';

class SearchAppBarWidget extends StatelessWidget {
  const SearchAppBarWidget({super.key});

  void _search(BuildContext cxt, String? val) {
    if ((val ?? '').isNotEmpty) {
      cxt.read<CatalogSearchBloc>().add(
            CatalogSearchEvent.search(
              text: val!,
              isForceUpdate: true,
            ),
          );
    }
  }

  void _back(BuildContext context) => context.maybePop();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchTextField(
            onChanged: (val) => _search(context, val),
          ),
        ),
        AppBoxes.kWidth8,
        InkWell(
          onTap: () => _back(context),
          child: Text(
            t.common.cancel,
            style: context.textStyle.buttonTypo.btn3semiBold.withColor(
              context.colors.buttonColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
