import 'dart:ui';

abstract class MapColors {
  const MapColors({
    required Color deliveryEnabled,
    required Color deliveryDisabled,
  })  : _deliveryEnabled = deliveryEnabled,
        _deliveryDisabled = deliveryDisabled;

  final Color _deliveryEnabled;
  final Color _deliveryDisabled;

  Color get borderEnabled => _deliveryEnabled;
  Color get borderDisabled => _deliveryDisabled;

  Color get fillEnabled => _deliveryEnabled.withOpacity(0.1);
  Color get fillDisabled => _deliveryDisabled.withOpacity(0.1);
}
