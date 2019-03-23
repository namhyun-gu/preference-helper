import 'package:equatable/equatable.dart';

abstract class PreferenceEvent extends Equatable {
  PreferenceEvent([List props = const []]) : super(props);
}

class FetchPreference extends PreferenceEvent {
  @override
  String toString() => 'FetchPreference';
}
