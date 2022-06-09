import 'package:aralan/models/activity_repository.dart';
import 'package:aralan/tiny_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(App(prefs: prefs));
}

class App extends StatelessWidget {
  final SharedPreferences prefs;
  const App({Key? key, required this.prefs}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppLifecycleReactor(prefs: prefs);
  }
}

bool isSameDate(DateTime a, b) {
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

class AppLifecycleReactor extends StatefulWidget {
  final SharedPreferences prefs;
  const AppLifecycleReactor({Key? key, required this.prefs}) : super(key: key);

  @override
  State<AppLifecycleReactor> createState() => _AppLifecycleReactorState();
}

class _AppLifecycleReactorState extends State<AppLifecycleReactor>
    with WidgetsBindingObserver {
  DateTime _now;

  _AppLifecycleReactorState() : _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final rightNow = DateTime.now();
      if (!isSameDate(_now, rightNow)) {
        setState(() {
          _now = rightNow;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActivityRepository(widget.prefs),
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
        },
        child: MaterialApp(
          title: 'Aralan',
          theme: TinyAppTheme.lightThemeData,
          home: HomePage(
            title: "Aralan",
            loadedAt: _now,
          ),
        ),
      ),
    );
  }
}
