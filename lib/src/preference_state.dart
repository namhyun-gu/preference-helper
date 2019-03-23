import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:preference_helper/src/preference.dart';

abstract class PreferenceState extends Equatable {
  PreferenceState([List props = const []]) : super(props);
}

class PreferenceLoading extends PreferenceState {
  @override
  String toString() => 'PreferenceLoading';
}

class PreferenceLoaded extends PreferenceState {
  final int updatedTime;
  final Map<String, Preference> preferences;

  PreferenceLoaded({
    @required this.updatedTime,
    @required this.preferences,
  })  : assert(updatedTime != null),
        assert(preferences != null),
        super([updatedTime, preferences]);

  @override
  String toString() =>
      'PreferenceLoaded{updatedTime: $updatedTime, preferences: $preferences}';
}
