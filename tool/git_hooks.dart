// ignore_for_file: avoid_print

import 'package:conventional/conventional.dart';
import 'package:git_hooks/git_hooks.dart';

void main(List<String> arguments) {
  final params = {Git.commitMsg: commitMsg, Git.preCommit: preCommit};
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  final commitMessage = Utils.getCommitEditMsg();
  final result = lintCommit(commitMessage);
  if (!result.valid) {
    print('COMMIT MESSAGE ERROR: ${result.message}');
  }
  return result.valid;
}

Future<bool> preCommit() async {
  print('Running flutter analyze...');
  var valid = true;
  // try {
  //   final result = await Process.run(
  //     '/home/wayne/apps/flutter/bin/flutter analyze',
  //     [],
  //     includeParentEnvironment: true,
  //     runInShell: true,
  //   );
  //   print(result.exitCode);
  //   print(result.stdout);
  //   if (result.exitCode != 0) {
  //     valid = false;
  //     print(result.stdout);
  //   }
  // } catch (e) {
  //   valid = false;
  //   print(e);
  // }
  return valid;
}
