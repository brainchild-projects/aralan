List<T> reorder<T>(List<T> list, int indexBefore, int indexAfter) {
  final removed = list.removeAt(indexBefore);
  list.insert(indexAfter, removed);
  return list;
}
