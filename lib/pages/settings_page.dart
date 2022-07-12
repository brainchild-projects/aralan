import 'package:aralan/elements/colored_scrollable_child.dart';
import 'package:aralan/elements/navigation_button.dart';
import 'package:aralan/pages/settings_pages/available_activities.dart';
import 'package:aralan/pages/settings_pages/daily_activities.dart';
import 'package:aralan/pages/settings_pages/todays_activities.dart';
import 'package:aralan/pages/test_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            leading: NavigationButton(
              positioned: false,
              icon: Icons.arrow_back,
              onPressed: () => {Navigator.pop(context)},
            ),
            extended: true,
            onDestinationSelected: (index) {
              if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TestPage()),
                );
                return;
              }
              setState(() {
                _selectedIndex = index;
                pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              });
            },
            // labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.today),
                label: Text('Today'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.view_list_outlined),
                label: Text('Daily'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text('Available'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.church),
                label: Text('Testing'),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              children: const [
                ColoredScrollableChild(
                  color: Colors.blue,
                  child: TodaysActivities(),
                ),
                ColoredScrollableChild(
                  color: Colors.green,
                  child: DailyActivities(),
                ),
                ColoredScrollableChild(
                  color: Colors.indigo,
                  child: AvailableActivities(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
