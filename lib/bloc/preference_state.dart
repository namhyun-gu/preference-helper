import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:preference_helper/model/preference.dart';

abstract class PreferenceState extends Equatable {
  PreferenceState([List props = const []]) : super(props);
}

class PreferenceLoading extends PreferenceState {}

class PreferenceLoaded extends PreferenceState {
  final int updatedTime;
  final List<Preference> preferences;

  PreferenceLoaded({
    @required this.updatedTime,
    @required this.preferences,
  })  : assert(updatedTime != null),
        assert(preferences != null),
        super([updatedTime, preferences]);

  Preference getPreference(String key) {
    return preferences.firstWhere((pref) => pref.key == key);
  }

  @override
  String toString() {
    return 'PreferenceLoaded{preferencesTimestamp: $updatedTime, preferences: $preferences}';
  }
}
