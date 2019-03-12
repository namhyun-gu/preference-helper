import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:preference_helper/bloc/preference_event.dart';
import 'package:preference_helper/bloc/preference_state.dart';
import 'package:preference_helper/model/exception.dart';
import 'package:preference_helper/model/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  final SharedPreferences sharedPreferences;
  final List<Preference> usagePreferences;

  PreferenceBloc({
    @required this.sharedPreferences,
    @required this.usagePreferences,
  })  : assert(sharedPreferences != null),
        assert(usagePreferences != null);

  @override
  PreferenceState get initialState => PreferenceLoading();

  @override
  Stream<PreferenceState> mapEventToState(
    PreferenceState currentState,
    PreferenceEvent event,
  ) async* {
    if (event is FetchPreference) {
      var preferences = usagePreferences
          .map((preference) => _getPreference(preference))
          .toList();
      var updatedTime = DateTime.now().millisecondsSinceEpoch;
      yield PreferenceLoaded(
        updatedTime: updatedTime,
        preferences: preferences,
      );
    }
  }

  Preference _getPreference(Preference preference) {
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
    dispatch(FetchPreference());
  }
}