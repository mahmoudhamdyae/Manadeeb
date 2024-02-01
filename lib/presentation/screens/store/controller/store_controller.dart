import 'package:get/get.dart';
import 'package:manadeeb/domain/models/note.dart';
import 'package:manadeeb/domain/repository/repository.dart';

import '../../../resources/strings_manager.dart';

class StoreController extends GetxController {

  final List<String> _sfoof = [
    AppStrings.saff4,
    AppStrings.saff5,
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

  final Rx<NotesResponse> _notes = NotesResponse().obs;
  final RxList<MandubBooks> filteredNotes = RxList.empty();
  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;
  final Rx<RxStatus> _tawreedStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get tawreedStatus => _tawreedStatus.value;

  final Repository _repository;
  StoreController(this._repository);


  @override
  void onInit() {
    super.onInit();
    _getAllNotes(_sfoof[_selected.value]);
  }

  void _filterNotes() {
    List<MandubBooks>? allMandubBooks = _notes.value.namdubStore?[0].mandubBooks;
    List<MandubBooks>? filteredMandubBooks = allMandubBooks?.where((element) => element.classroom == _sfoof[_selected.value]).toList();
    filteredNotes.value = filteredMandubBooks ?? [];
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

  Future<void> tawreed(int bookId, int index) async {
    _tawreedStatus.value = RxStatus.loading();
    try {
      await _repository.tawreed(bookId).then((value) {
        _tawreedStatus.value = RxStatus.success();
        // var x = filteredNotes.firstWhere((element) => element.id == bookId);
        // x.pivot?.station = 0;
        // int count = -1;
        // filteredNotes.forEach((element) {
        //   count++;
        //   if (index == count) {
        //     filteredNotes.remove(element);
        //     filteredNotes.add(x);
        //   } else {
        //     filteredNotes.remove(element);
        //     filteredNotes.add(element);
        //   }
        // });
        // _getAllNotes(_sfoof[_selected.value]);
        // _status.value = RxStatus.loading();
        try {
          _repository.getNotes(_sfoof[_selected.value]).then((remoteNotes) {
            _status.value = RxStatus.success();
            _notes.value = remoteNotes;
            _filterNotes();
          });
        } on Exception catch (e) {
          _status.value = RxStatus.error(e.toString());
        }
      });
    } on Exception catch (e) {
      _tawreedStatus.value = RxStatus.error(e.toString());
    }
  }
}