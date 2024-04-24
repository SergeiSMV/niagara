import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/app_bar.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/search_text_field.dart';
import 'package:niagara_app/features/location/presentation/search_address/bloc/search_address_bloc.dart';
import 'package:niagara_app/features/location/presentation/search_address/widgets/location_list_widget.dart';
import 'package:niagara_app/features/location/presentation/search_address/widgets/location_loader_widget.dart';
import 'package:niagara_app/features/location/presentation/search_address/widgets/location_no_found_widget.dart';
import 'package:niagara_app/features/location/presentation/search_address/widgets/search_bar_back_button.dart';

@RoutePage()
class SearchAddressPage extends StatelessWidget {
  const SearchAddressPage({super.key});

  void _onInputChanged(BuildContext context, String? value) {
    context
        .read<SearchAddressBloc>()
        .add(SearchAddressEvent.inputChanged(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        automaticallyImplyLeading: false,
        titleWidget: SearchTextField(
          onChanged: (value) => _onInputChanged(context, value),
        ),
        actions: const [SearchBarBackButton()],
      ),
      body: BlocBuilder<SearchAddressBloc, SearchAddressState>(
        builder: (_, state) => state.when(
          initial: SizedBox.new,
          loading: LocationLoaderWidget.new,
          loaded: LocationListWidget.new,
          error: LocationNotFoundWidget.new,
        ),
      ),
    );
  }
}
