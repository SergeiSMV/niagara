import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/helpers/cyrillic_validation_helper.dart';
import '../../../../../../core/utils/gen/strings.g.dart';

part 'profile_validator_state.dart';
part 'profile_validator_cubit.freezed.dart';

/// [Cubit] для валидации данных профиля
///
/// Возвращает текущее состояние ошибок валидации
@injectable
class ProfileValidatorCubit extends Cubit<ProfileValidatorState> {
  ProfileValidatorCubit() : super(const ProfileValidatorState.initial());

  /// Валидирует имя
  void validateName(String name) {
    String? error = CyrillicValidationHelper.validateCyrillicText(name);
    if (error == null && name.length < 2) {
      error = t.profile.edit.validate_length_error;
    }
    emit(
      state.copyWith(
        nameError: error,
        surnameError: state.surnameError,
      ),
    );
  }

  /// Валидирует фамилию
  void validateSurname(String surname) {
    String? error = CyrillicValidationHelper.validateCyrillicText(surname);
    if (error == null && surname.length < 2) {
      error = t.profile.edit.validate_length_error;
    }
    emit(
      state.copyWith(
        nameError: state.nameError,
        surnameError: error,
      ),
    );
  }
}
