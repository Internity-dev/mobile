import 'package:shared_preferences/shared_preferences.dart';

import '../riverpod_and_hooks.dart';

final sharedPrefProvider = Provider((ref) async {
  return await SharedPreferences.getInstance();
});
