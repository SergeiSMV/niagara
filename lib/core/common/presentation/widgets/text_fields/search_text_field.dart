import 'package:flutter/material.dart' hide OutlineInputBorder;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/constants/app_insets.dart';
import 'package:niagara_app/core/utils/constants/app_sizes.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';
import 'package:niagara_app/core/utils/gen/assets.gen.dart';
import 'package:niagara_app/core/utils/gen/strings.g.dart';

class SearchTextField extends HookWidget {
  /// Принимает параметры:
  /// - [key] - ключ виджета,
  /// - [onChanged] - функция, которая вызывается при изменении значения в поле
  const SearchTextField({
    super.key,
    this.onChanged,
  });

  /// Функция, которая будет вызвана при изменении значения в поле
  final void Function(String?)? onChanged;

  String get _fieldName => AppConstants.kSearchTextFieldName;

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final searchCtrl = useSearchController();
    useListenable(searchCtrl);

    return FormBuilderTextField(
      key: formKey,
      name: _fieldName,
      controller: searchCtrl,
      keyboardType: TextInputType.text,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.words,
      autofocus: true,
      style: context.textStyle.textTypo.tx1Medium,
      cursorColor: context.colors.textColors.accent,
      onChanged: (value) {
        if (onChanged != null) onChanged!.call(value);
      },
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        contentPadding: AppInsets.kSymmetricV12,
        hintText: t.search.inputField,
        prefixIconConstraints: const BoxConstraints(),
        suffixIconConstraints: const BoxConstraints(),
        prefixIcon: const _SearchIconWidget(),
        suffixIcon: searchCtrl.text.isNotEmpty
            ? _ClearButton(
                searchCtrl: searchCtrl,
                onChanged: onChanged,
              )
            : null,
        focusedBorder:
            context.theme.inputDecorationTheme.focusedBorder?.copyWith(
          borderSide: BorderSide(
            color: context.colors.fieldBordersColors.accent,
          ),
        ),
        enabledBorder: context.theme.inputDecorationTheme.border?.copyWith(
          borderSide: BorderSide(
            color: context.colors.fieldBordersColors.main,
          ),
        ),
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({
    required this.searchCtrl,
    required this.onChanged,
  });

  final SearchController searchCtrl;
  final void Function(String? p1)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kOnlyRight12,
      child: InkWell(
        child: Assets.icons.closeFilling.svg(
          width: AppSizes.kIconMedium,
          height: AppSizes.kIconMedium,
        ),
        onTap: () {
          searchCtrl.clear();
          if (onChanged != null) onChanged!.call(null);
        },
      ),
    );
  }
}

class _SearchIconWidget extends StatelessWidget {
  const _SearchIconWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppInsets.kOnlyTop12 +
          AppInsets.kOnlyBottom12 +
          AppInsets.kOnlyLeft12 +
          AppInsets.kOnlyRight6,
      child: Assets.icons.search.svg(
        width: AppSizes.kIconMedium,
        height: AppSizes.kIconMedium,
      ),
    );
  }
}
