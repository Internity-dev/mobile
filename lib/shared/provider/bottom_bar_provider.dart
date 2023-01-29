import '../riverpod_and_hooks.dart';

class BottomBarProvider extends StateNotifier<int> {
  BottomBarProvider() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final bottomBarProvider =
    StateNotifierProvider.autoDispose<BottomBarProvider, int>((ref) {
  return BottomBarProvider();
});
