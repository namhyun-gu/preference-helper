# preference_helper

![Pub](https://img.shields.io/pub/v/preference_helper.svg)

> A package that makes shared_preferences easier to use, This package is built with [bloc](https://pub.dartlang.org/packages/bloc), [shared_preferences](https://pub.dartlang.org/packages/shared_preferences)

## Usage

- Initialize bloc

```dart
var sharedPreferences = await SharedPreferences.getInstance();
// Build PreferenceBloc with manage preference in bloc
var preferenceBloc = PreferenceBloc(
  sharedPreferences: sharedPreferences,
  usagePreferences: [
    Preference<int>(
      key: 'counter',
      initValue: 0,
    ),
  ],
);
```

- Provide PreferenceBloc with BlocProvider

```dart
void main() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    preferenceBloc: PreferenceBloc(
      sharedPreferences: sharedPreferences,
      usagePreferences: [
        Preference<int>(
          key: 'counter',
          initValue: 0,
        ),
      ],
    ),
  ));
}

class MyApp extends StatelessWidget {
  final PreferenceBloc preferenceBloc;

  MyApp({@required this.preferenceBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreferenceBloc>(
      bloc: preferenceBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
```

- Use preferences in widget with BlocBuilder

```dart
@override
Widget build(BuildContext context) {
  return BlocBuilder<PreferenceEvent, PreferenceState>(
    bloc: BlocProvider.of<PreferenceBloc>(context),
    builder: (BuildContext context, PreferenceState state) {
      var counter = state.preferences['counter'].value;
      return Text(count.toString());
    };
  );
}
```

- Use preferences in widget without BlocBuilder

```dart
var prefCounter = preferenceBloc.getPreference(Preference<int>(
  key: "counter",
  initValue: 0,
));

print(prefCounter.value);

// or

var prefTypedCounter = preferenceBloc.getTypePreference<int>(
  key: "counter",
  initValue: 0,
);

print(prefTypedCounter.value);
```

> You can see this code blocks in example project. check this [link](https://github.com/namhyun-gu/preference-helper/tree/master/example)

## License

```
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>
```
