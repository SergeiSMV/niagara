import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CrashlyticsTalkerObserver extends TalkerObserver {
  const CrashlyticsTalkerObserver();

  FirebaseCrashlytics get _crashlytics => FirebaseCrashlytics.instance;

  @override
  void onLog(TalkerData log) => _crashlytics.log(log.generateTextMessage());

  @override
  void onError(TalkerError err) => _crashlytics.recordError(
        err.error,
        err.stackTrace,
        reason: err.message,
        fatal: err.logLevel == LogLevel.critical,
      );

  @override
  void onException(TalkerException err) => _crashlytics.recordError(
        err.exception,
        err.stackTrace,
        reason: err.message,
        fatal: err.logLevel == LogLevel.critical,
      );
}
