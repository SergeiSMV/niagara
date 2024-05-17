// ignore_for_file: parameter_assignments

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';
import 'package:niagara_app/core/utils/extensions/build_context_ext.dart';

enum CountDownTimerFormat {
  daysHoursMinutesSeconds,
  daysHoursMinutes,
  daysHours,
  daysOnly,
  hoursMinutesSeconds,
  hoursMinutes,
  hoursOnly,
  minutesSeconds,
  minutesOnly,
  secondsOnly,
}

typedef OnTickCallBack = void Function(Duration remainingTime);

class TimerCountdown extends StatefulWidget {
  const TimerCountdown({
    required this.endTime,
    super.key,
    this.format = CountDownTimerFormat.daysHoursMinutesSeconds,
    this.enableDescriptions = true,
    this.onEnd,
    this.timeTextStyle,
    this.onTick,
    this.colonsTextStyle,
    this.descriptionTextStyle,
    this.daysDescription = 'Days',
    this.hoursDescription = 'Hours',
    this.minutesDescription = 'Minutes',
    this.secondsDescription = 'Seconds',
    this.spacerWidth = 10,
  });

  /// Format for the timer countdown,
  /// choose between different `CountDownTimerFormat`s
  final CountDownTimerFormat format;

  /// Defines the time when the timer is over.
  final DateTime endTime;

  /// Gives you remaining time after every tick.
  final OnTickCallBack? onTick;

  /// Function to call when the timer is over.
  final VoidCallback? onEnd;

  /// Toggle time units descriptions.
  final bool enableDescriptions;

  /// `TextStyle` for the time numbers.
  final TextStyle? timeTextStyle;

  /// `TextStyle` for the colons between the time numbers.
  final TextStyle? colonsTextStyle;

  /// `TextStyle` for the description
  final TextStyle? descriptionTextStyle;

  /// Days unit description.
  final String daysDescription;

  /// Hours unit description.
  final String hoursDescription;

  /// Minutes unit description.
  final String minutesDescription;

  /// Seconds unit description.
  final String secondsDescription;

  /// Defines the width between the colons and the units.
  final double spacerWidth;

  @override
  TimerCountdownState createState() => TimerCountdownState();
}

class TimerCountdownState extends State<TimerCountdown> {
  Timer? timer;
  late String countdownDays;
  late String countdownHours;
  late String countdownMinutes;
  late String countdownSeconds;
  late Duration difference;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  void _startTimer() {
    if (widget.endTime.isBefore(DateTime.now())) {
      difference = Duration.zero;
    } else {
      difference = widget.endTime.difference(DateTime.now());
    }

    countdownDays = _durationToStringDays(difference);
    countdownHours = _durationToStringHours(difference);
    countdownMinutes = _durationToStringMinutes(difference);
    countdownSeconds = _durationToStringSeconds(difference);

    if (difference == Duration.zero) {
      if (widget.onEnd != null) {
        widget.onEnd!.call();
      }
    } else {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        difference = widget.endTime.difference(DateTime.now());
        widget.onTick?.call(difference);
        setState(() {
          countdownDays = _durationToStringDays(difference);
          countdownHours = _durationToStringHours(difference);
          countdownMinutes = _durationToStringMinutes(difference);
          countdownSeconds = _durationToStringSeconds(difference);
        });
        if (difference <= Duration.zero) {
          timer.cancel();
          if (widget.onEnd != null) {
            widget.onEnd!.call();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => _countDownTimerFormat();

  /// Builds the UI colons between the time units.
  Widget _colon() {
    return Row(
      children: [
        SizedBox(
          width: widget.spacerWidth,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ':',
              style: widget.colonsTextStyle,
            ),
            if (widget.enableDescriptions) const SizedBox(height: 5),
            if (widget.enableDescriptions)
              Text(
                '',
                style: widget.descriptionTextStyle,
              ),
          ],
        ),
        SizedBox(
          width: widget.spacerWidth,
        ),
      ],
    );
  }

  /// Builds the timer data with its description.
  Widget _buildTimerData({
    required String data,
    required String description,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: data
              .split('')
              .map(
                (s) => Container(
                  width: 34,
                  height: 48,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: context.colors.mainColors.white.withOpacity(.9),
                    borderRadius: BorderRadius.circular(AppConst.kCommon8),
                  ),
                  child: Text(s, style: widget.timeTextStyle),
                ),
              )
              .toList(),
        ),
        if (widget.enableDescriptions)
          const SizedBox(
            height: 5,
          ),
        if (widget.enableDescriptions)
          Text(
            description,
            style: widget.descriptionTextStyle,
          ),
      ],
    );
  }

  String _twoDigits(int n, String unitType) {
    switch (unitType) {
      case 'minutes':
        if (widget.format == CountDownTimerFormat.daysHoursMinutes ||
            widget.format == CountDownTimerFormat.hoursMinutes ||
            widget.format == CountDownTimerFormat.minutesOnly) {
          if (difference > Duration.zero) {
            n++;
          }
        }
        if (n >= 10) return '$n';
        return '0$n';
      case 'hours':
        if (widget.format == CountDownTimerFormat.daysHours ||
            widget.format == CountDownTimerFormat.hoursOnly) {
          if (difference > Duration.zero) {
            n++;
          }
        }
        if (n >= 10) return '$n';
        return '0$n';
      case 'days':
        if (widget.format == CountDownTimerFormat.daysOnly) {
          if (difference > Duration.zero) {
            n++;
          }
        }
        if (n >= 10) return '$n';
        return '0$n';
      default:
        if (n >= 10) return '$n';
        return '0$n';
    }
  }

  /// Convert [Duration] in days to String for UI.
  String _durationToStringDays(Duration duration) {
    return _twoDigits(duration.inDays, 'days');
  }

  /// Convert [Duration] in hours to String for UI.
  String _durationToStringHours(Duration duration) {
    if (widget.format == CountDownTimerFormat.hoursMinutesSeconds ||
        widget.format == CountDownTimerFormat.hoursMinutes ||
        widget.format == CountDownTimerFormat.hoursOnly) {
      return _twoDigits(duration.inHours, 'hours');
    } else {
      return _twoDigits(duration.inHours.remainder(24), 'hours');
    }
  }

  /// Convert [Duration] in minutes to String for UI.
  String _durationToStringMinutes(Duration duration) {
    if (widget.format == CountDownTimerFormat.minutesSeconds ||
        widget.format == CountDownTimerFormat.minutesOnly) {
      return _twoDigits(duration.inMinutes, 'minutes');
    } else {
      return _twoDigits(duration.inMinutes.remainder(60), 'minutes');
    }
  }

  /// Convert [Duration] in seconds to String for UI.
  String _durationToStringSeconds(Duration duration) {
    if (widget.format == CountDownTimerFormat.secondsOnly) {
      return _twoDigits(duration.inSeconds, 'seconds');
    } else {
      return _twoDigits(duration.inSeconds.remainder(60), 'seconds');
    }
  }

  /// Switches the UI to be displayed based on [CountDownTimerFormat].
  Widget _countDownTimerFormat() {
    switch (widget.format) {
      case CountDownTimerFormat.daysHoursMinutesSeconds:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownDays,
              description: widget.daysDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownHours,
              description: widget.hoursDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownMinutes,
              description: widget.minutesDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownSeconds,
              description: widget.secondsDescription,
            ),
          ],
        );
      case CountDownTimerFormat.daysHoursMinutes:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownDays,
              description: widget.daysDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownHours,
              description: widget.hoursDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownMinutes,
              description: widget.minutesDescription,
            ),
          ],
        );
      case CountDownTimerFormat.daysHours:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownDays,
              description: widget.daysDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownHours,
              description: widget.hoursDescription,
            ),
          ],
        );
      case CountDownTimerFormat.daysOnly:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownDays,
              description: widget.daysDescription,
            ),
          ],
        );
      case CountDownTimerFormat.hoursMinutesSeconds:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownHours,
              description: widget.hoursDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownMinutes,
              description: widget.minutesDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownSeconds,
              description: widget.secondsDescription,
            ),
          ],
        );
      case CountDownTimerFormat.hoursMinutes:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownHours,
              description: widget.hoursDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownMinutes,
              description: widget.minutesDescription,
            ),
          ],
        );
      case CountDownTimerFormat.hoursOnly:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownHours,
              description: widget.hoursDescription,
            ),
          ],
        );
      case CountDownTimerFormat.minutesSeconds:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownMinutes,
              description: widget.minutesDescription,
            ),
            _colon(),
            _buildTimerData(
              data: countdownSeconds,
              description: widget.secondsDescription,
            ),
          ],
        );

      case CountDownTimerFormat.minutesOnly:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownMinutes,
              description: widget.minutesDescription,
            ),
          ],
        );
      case CountDownTimerFormat.secondsOnly:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTimerData(
              data: countdownSeconds,
              description: widget.secondsDescription,
            ),
          ],
        );
    }
  }
}
