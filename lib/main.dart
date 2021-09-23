import 'package:aralan/models/activity_list_data.dart';
import 'package:aralan/tiny_app_theme.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActivityListData(),
      child: MaterialApp(
        title: 'Aralan',
        theme: TinyAppTheme.lightThemeData,
        home: const HomePage(title: "Aralan"),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final entries = Provider.of<ActivityListData>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Today’s Schedule',
              style: theme.textTheme.headline1,
            ),
            Text(
              formatDate(
                DateTime.now(),
                [DD, ', ', MM, ' ', d, ', ', yyyy],
              ),
              style: theme.textTheme.headline3,
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
                    controlAffinity: ListTileControlAffinity.leading,
                    value: activity.isDone,
                    title:
                        Text(activity.name, style: theme.textTheme.headline3),
                    onChanged: (foo) {
                      entries.toggleActivity(activity);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
