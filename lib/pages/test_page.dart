import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<String> list = [
    'A',
    'B',
    'C',
    'D',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView(
        buildDefaultDragHandles: true,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = list.removeAt(oldIndex);
            list.insert(newIndex, item);
          });
        },
        children: list.map((e) {
          return ListTile(
            key: Key(e),
            title: Text(e),
          );
        }).toList(),
      ),
    );
  }
}
