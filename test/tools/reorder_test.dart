import 'package:aralan/tools/reorder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('reorder()', () {
    test('It should move 2nd  element to first', () {
      final list = [1, 2, 3, 4];
      expect(reorder(list, 1, 0), [2, 1, 3, 4]);
    });

    test('It should move 3rd  element to last', () {
      final list = [1, 2, 3, 4];
      expect(reorder(list, 2, 3), [1, 2, 4, 3]);
    });

    test('It should move last element to first', () {
      final list = [1, 2, 3, 4];
      expect(reorder(list, 3, 0), [4, 1, 2, 3]);
    });
  });
}
