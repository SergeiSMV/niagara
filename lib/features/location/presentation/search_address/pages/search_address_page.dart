import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niagara_app/core/common/presentation/widgets/text_fields/search_text_field.dart';
import 'package:niagara_app/features/location/presentation/search_address/bloc/search_address_bloc.dart';
import 'package:niagara_app/features/location/presentation/search_address/widgets/search_bar_back_button.dart';

@RoutePage()
class SearchAddressPage extends StatelessWidget {
  const SearchAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchAddressBloc>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SearchTextField(
          onChanged: (value) =>
              searchBloc.add(SearchAddressEvent.inputChanged(value)),
        ),
        actions: const [SearchBarBackButton()],
      ),
      body: BlocBuilder<SearchAddressBloc, SearchAddressState>(
        builder: (context, state) {
          return Column();
        },
      ),
    );
  }
}
