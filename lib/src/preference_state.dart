import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:preference_helper/src/preference.dart';

class PreferenceState extends Equatable {
  final int updatedTime;
  final Map<String, Preference> preferences;

  PreferenceState({
    @required this.updatedTime,
    @required this.preferences,
  })  : assert(updatedTime != null),
        assert(preferences != null),
        super([updatedTime, preferences]);

  @override
  String toString() =>
      'PreferenceState{updatedTime: $updatedTime, preferences: $preferences}';
}
