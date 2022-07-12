import 'package:flutter/material.dart';

import '../models/activity.dart';

typedef ActivityItemBuilder<T extends ActivityLike> = Widget Function(
    T activity, BuildContext context, int index);

typedef OnReorder = void Function(int oldIndex, int newIndex);

class ListContainer<T extends ActivityLike> extends StatelessWidget {
  final List<T> list;
  final ActivityItemBuilder<T> builder;
  final double width;
  final OnReorder? onReorder;
  const ListContainer({
    Key? key,
    required this.list,
    required this.builder,
    this.width = 560,
    this.onReorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(
      vertical: 50,
      horizontal: 8,
    );
    if (onReorder != null) {
      return ReorderableListView.builder(
        padding: padding,
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return builder(list[index], context, index);
        },
        onReorder: (before, after) {
          if (onReorder != null) {
            onReorder!(before, after);
          }
        },
      );
    }
    return ListView.builder(
      padding: padding,
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return builder(list[index], context, index);
      },
    );
  }
}
