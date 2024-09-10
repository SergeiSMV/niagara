import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:niagara_app/core/core.dart';
import 'package:niagara_app/features/notifications/domain/use_cases/read_notification_use_case.dart';

part 'read_notification_cubit.freezed.dart';
part 'read_notification_state.dart';

@injectable
class ReadNotificationCubit extends Cubit<ReadNotificationState> {
  ReadNotificationCubit(
    this._readNotificationUseCase,
  ) : super(const ReadNotificationState.initial());

  final ReadNotificationUseCase _readNotificationUseCase;

  void readNotification(String id) => _readNotificationUseCase(id);
}
