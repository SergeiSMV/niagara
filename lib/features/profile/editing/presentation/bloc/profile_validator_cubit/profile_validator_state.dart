part of 'profile_validator_cubit.dart';

/// Состояние валидации профиля
@freezed
class ProfileValidatorState with _$ProfileValidatorState {
  const factory ProfileValidatorState.initial({
    /// Ошибка валидации имени
    @Default(null) String? nameError,

    /// Ошибка валидации фамилии
    @Default(null) String? surnameError,
  }) = _ProfileValidatorState;
}
