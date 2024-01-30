import 'package:get/get.dart';

import '../../../resources/strings_manager.dart';

class StoreController extends GetxController {

  final List<String> _sfoof = [
    AppStrings.saff6,
    AppStrings.saff7,
    AppStrings.saff8,
    AppStrings.saff9,
    AppStrings.saff10,
    AppStrings.saff11,
    AppStrings.saff12,
  ];

  final RxInt _selected = 0.obs;

  List<String> get sfoof => _sfoof;

  int getSfoofLength() {
    return _sfoof.length;
  }

  bool isSelected(int index) {
    return _selected.value == index;
  }

  void select(int index) {
    _selected.value = index;
  }
}