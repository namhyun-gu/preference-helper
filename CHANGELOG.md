## 0.0.5

- Add wrapper class Preferences for preference lists use PreferenceState
- Change preferences field type List<Preference> to Preferences class
- Rename getTypePreference<T> to getPreference<T>
- Change setPreference method to private, use dispatch event UpdatePreference instead of setPreference

## 0.0.4+1

- Update documentation

## 0.0.4

- Change bloc init state to loaded preference state
- Remove PreferenceLoading, PreferenceLoaded state
- Rename FetchPreference event to UpdatePreference

## 0.0.3

- Add documentation comments
- Change getPreferences method to public

## 0.0.2

- Apply package layout convention

## 0.0.1

- Initial release
