import 'package:aralan/settings_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'elements/navigation_button.dart';
import 'models/activity_list_data.dart';

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
        child: Stack(
          children: [
            NavigationButton(
              icon: Icons.settings,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                )
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
          ],
        ),
      ),
    );
  }
}
