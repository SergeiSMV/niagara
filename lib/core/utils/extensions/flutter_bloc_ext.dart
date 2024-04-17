import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

extension BlocDebounceExt on Bloc<dynamic, dynamic> {
  EventTransformer<E> debounce<E>({
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return (events, mapper) {
      return events.debounce(duration).switchMap(mapper);
    };
  }
}
