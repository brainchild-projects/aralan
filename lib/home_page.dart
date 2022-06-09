import 'package:aralan/elements/list_container.dart';
import 'package:aralan/elements/toggle_activity.dart';
import 'package:aralan/models/activity.dart';
import 'package:aralan/models/activity_repository.dart';
import 'package:aralan/settings_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'elements/navigation_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, required this.loadedAt})
      : super(key: key);

  final String title;
  final DateTime loadedAt;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime now;

  @override
  initState() {
    super.initState();
    now = widget.loadedAt;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final repo = Provider.of<ActivityRepository>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            NavigationButton(
              icon: Icons.settings,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                ).then((_) {
                  setState(() {
                    now = DateTime.now();
                  });
                })
              },
            ),
            Center(
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
                      now,
                      [DD, ', ', MM, ' ', d, ', ', yyyy],
                    ),
                    style: theme.textTheme.headline4,
                  ),
                  SizedBox(
                    width: 560,
                    child: ListContainer<CheckableActivity>(
                      list: repo.activitiesToday(now).activities,
                      builder: (activity, context) {
                        return ToggleActivity(
                          activity: activity,
                          onToggle: (foo) {
                            repo.toggleActivityToday(activity, now);
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    'Reload At: $now',
                    style: theme.textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
