import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_provider/provider/future.dart';

final counterNotifierProvider =
    AsyncNotifierProvider<CounterNotifier, int>(CounterNotifier.new);

class CounterNotifier extends AsyncNotifier<int> {
  @override
  FutureOr<int> build() {
    return 0;
  }

  Future<void> increment() async {
    final counter = ref.read(countStateProvider.notifier).state++;
    final SharedPreferences prefs = await ref.read(sharedProvider.future);
    final set = prefs.setInt('counter', counter);
    final int? sum = prefs.getInt('counter');
    print(sum); // 保存された値をログに表示
  }

  Future<void> delete() async {
    final SharedPreferences prefs = await ref.read(sharedProvider.future);
    final delete = await prefs.remove('counter');
  }
}