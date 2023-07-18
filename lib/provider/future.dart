// SharedPreferencesを使用するための非同期のプロバイダー
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// 数値を表示するプロバイダー
final countStateProvider = StateProvider<int>((ref) => 0);
// SharedPreferencesは、非同期処理が必要なので、FutureProviderを使用する
// SharedPreferencesから保存されたデータを表示する
final countFutureProvider = FutureProvider<int?>((ref) async {
  final pref = await SharedPreferences.getInstance();
  return pref.getInt('counter');
});