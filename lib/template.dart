import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_provider/provider/future.dart';
import 'package:shared_provider/provider/state.dart';

class TemplatePage extends ConsumerWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SharedPreferencesを呼び出す
    final future = ref.watch(countFutureProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                // 保存したデータを削除する
                // final SharedPreferences prefs =
                //     await SharedPreferences.getInstance();
                // final success = await prefs.remove('counter');
                await ref.read(counterNotifierProvider.notifier).delete();
                // ボタンを押すたびにref.refreshを呼び出す
                await ref.refresh(countFutureProvider);
              },
              icon: const Icon(Icons.delete))
        ],
        title: const Text('FutureProvider'),
      ),
      // 数値をSharedPreferencesに保存するロジック
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(counterNotifierProvider.notifier).increment();
          // ボタンを押すたびにref.refreshを呼び出す
          await ref.refresh(countFutureProvider);
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        // FutureProviderのデータを取得する
        child: future.when(
          error: (err, _) => Text(err.toString()), //エラー時
          loading: () => const CircularProgressIndicator(), //読み込み時
          data: (data) => Text(data.toString()), // 保存された値を表示
        ),
      ),
    );
  }
}
