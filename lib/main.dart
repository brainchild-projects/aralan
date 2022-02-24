import 'package:aralan/models/activity_list_data.dart';
import 'package:aralan/tiny_app_theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const AppLifecycleReactor();
  }
}

bool isSameDate(DateTime a, b) {
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

class AppLifecycleReactor extends StatefulWidget {
  const AppLifecycleReactor({Key? key}) : super(key: key);

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
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
      create: (context) => ActivityListData(_now),
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

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title, required this.loadedAt})
      : super(key: key);

  final String title;
  final DateTime loadedAt;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final entries = Provider.of<ActivityListData>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              Text(
                'Today’s Schedule',
                style: theme.textTheme.headline3,
              ),
              Text(
                formatDate(
                  loadedAt,
                  [DD, ', ', MM, ' ', d, ', ', yyyy],
                ),
                style: theme.textTheme.headline4,
              ),
              SizedBox(
                width: 560,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 8,
                  ),
                  itemCount: entries.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var activity = entries[index];
                    return CheckboxListTile(
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: activity.isDone,
                      title: Text(
                        activity.name,
                        style: theme.textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onChanged: (foo) {
                        entries.toggleActivity(activity);
                      },
                    );
                  },
                ),
              ),
              Text(
                'Loaded At: $loadedAt',
                style: theme.textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
