import 'package:equatable/equatable.dart';
import 'package:preference_helper/src/preference.dart';

abstract class PreferenceEvent extends Equatable {
  PreferenceEvent([List props = const []]) : super(props);
}

/// Update preference event
///
/// ```
/// For example:
///
/// var counterPref = state.preferences.get<int>("counter")
/// counterPref.value += 1;
/// preferenceBloc.dispatch(UpdatePreference(counterPref));
/// ```
class UpdatePreference extends PreferenceEvent {
  final Preference updatedPreference;

  UpdatePreference(this.updatedPreference) : super([updatedPreference]);

  @override
  String toString() => 'UpdatePreference';
}
