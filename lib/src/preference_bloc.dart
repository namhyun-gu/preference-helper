import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:preference_helper/src/preference.dart';
import 'package:preference_helper/src/preference_event.dart';
import 'package:preference_helper/src/preference_state.dart';
import 'package:preference_helper/src/type_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  final SharedPreferences sharedPreferences;

  /// The list of [Preference] usage in bloc
  final List<Preference> usagePreferences;

  PreferenceBloc({
    @required this.sharedPreferences,
    @required this.usagePreferences,
  })  : assert(sharedPreferences != null),
        assert(usagePreferences != null);

  @override
  PreferenceState get initialState => _loadPreferences();

  @override
  Stream<PreferenceState> mapEventToState(
    PreferenceState currentState,
    PreferenceEvent event,
  ) async* {
    if (event is UpdatePreference) {
      yield _loadPreferences();
    }
  }

  PreferenceState _loadPreferences() {
    var preferencesMap = Map<String, Preference>();
    usagePreferences
        .map((preference) => getPreference(preference))
        .forEach((preference) => preferencesMap[preference.key] = preference);
    var updatedTime = DateTime.now().millisecondsSinceEpoch;
    return PreferenceState(
      updatedTime: updatedTime,
      preferences: preferencesMap,
    );
  }

  /// Returns filled value [Preference] by [Preference] from [SharedPreferences]
  Preference getPreference(Preference preference) {
    var preferenceType = preference.typeOfPreference();
    if (preferenceType == int) {
      preference.value = sharedPreferences.getInt(preference.key);
    } else if (preferenceType == double) {
      preference.value = sharedPreferences.getDouble(preference.key);
    } else if (preferenceType == String) {
      preference.value = sharedPreferences.getString(preference.key);
    } else if (preferenceType == bool) {
      preference.value = sharedPreferences.getBool(preference.key);
    } else if (preferenceType == List) {
      preference.value = sharedPreferences.getStringList(preference.key);
    } else {
      throw TypeException();
    }
    if (preference.value == null) {
      preference.value = preference.initValue;
    }
    return preference;
  }

  Preference<T> getTypePreference<T>({String key, T initValue}) {
    return getPreference(Preference<T>(key: key, initValue: initValue));
  }

  /// Set [Preference] to [SharedPreferences] and notify bloc
  Future setPreference(Preference preference) async {
    var preferenceType = preference.typeOfPreference();
    if (preferenceType == int) {
      await sharedPreferences.setInt(preference.key, preference.value);
    } else if (preferenceType == double) {
      await sharedPreferences.setDouble(preference.key, preference.value);
    } else if (preferenceType == String) {
      await sharedPreferences.setString(preference.key, preference.value);
    } else if (preferenceType == bool) {
      await sharedPreferences.setBool(preference.key, preference.value);
    } else if (preferenceType == List) {
      await sharedPreferences.setStringList(preference.key, preference.value);
    } else {
      throw TypeException();
    }
    dispatch(UpdatePreference());
  }
}
