import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preference_helper/preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PreferenceBloc _preferenceBloc;

  void _incrementCounter() {
    var state = _preferenceBloc.currentState;
    if (state is PreferenceState) {
      var counterPref = state.preferences['counter'];
      counterPref.value += 1;
      _preferenceBloc.setPreference(counterPref);
    }
  }

  @override
  void initState() {
    _preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferenceEvent, PreferenceState>(
      bloc: _preferenceBloc,
      builder: (BuildContext context, PreferenceState state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  (state is PreferenceState
                          ? state.preferences['counter'].value
                          : 0)
                      .toString(),
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
