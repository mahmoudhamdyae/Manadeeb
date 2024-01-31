import 'package:get/get.dart';
import 'package:manadeeb/domain/repository/repository.dart';

import '../../../../domain/models/note.dart';
import '../../../resources/strings_manager.dart';

class StoreController extends GetxController {

  final List<String> _sfoof = [
    // AppStrings.saff4,
    // AppStrings.saff5,
    AppStrings.saff6,
    AppStrings.saff7,
    AppStrings.saff8,
    AppStrings.saff9,
    AppStrings.saff10,
    AppStrings.saff11,
    AppStrings.saff12,
  ];

  List<String> get sfoof => _sfoof;
  int getSfoofLength() {
    return _sfoof.length;
  }

  final RxInt _selected = 0.obs;
  bool isSelected(int index) {
    return _selected.value == index;
  }
  void select(int index) {
    _selected.value = index;
    _filterNotes();
  }

  final RxList<Note> _notes = RxList.empty();
  final RxList<Note> filteredNotes = RxList.empty();
  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  StoreController(this._repository);


  @override
  void onInit() {
    super.onInit();
    _getAllNotes(_sfoof[_selected.value]);
  }

  void _filterNotes() {
    filteredNotes.value = _notes.where((element) => element.classroom == _sfoof[_selected.value]).toList();
  }

  void _getAllNotes(String saff) {
    _status.value = RxStatus.loading();
    try {
      _repository.getNotes(saff).then((remoteNotes) {
        _status.value = RxStatus.success();
        _notes.value = remoteNotes;
        _filterNotes();
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}