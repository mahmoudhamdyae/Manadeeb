import 'package:get/get.dart';
import 'package:manadeeb/domain/models/notes_and_packages.dart';
import 'package:manadeeb/domain/repository/repository.dart';

class AddOrderController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final RxList<Books> books = RxList.empty();
  final RxList<bool> checkedBooks = RxList.empty();
  final RxList<Packages> packages = RxList.empty();
  final RxList<bool> checkedPackages = RxList.empty();
  final RxInt price = 0.obs;

  final Repository _repository;
  AddOrderController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getNotesAndPackages();
  }

  void _getNotesAndPackages() {
    _status.value = RxStatus.loading();
    try {
      _repository.getNotesAndPackages().then((notesAndPackages) {
        _status.value = RxStatus.success();
        books.value = notesAndPackages.books ?? [];
        checkedBooks.value = List.generate(books.value.length, (index) => false);
        packages.value = notesAndPackages.packages ?? [];
        checkedPackages.value = List.generate(packages.length, (index) => false);
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void checkNote(int index) {
    checkedBooks[index] = !checkedBooks[index];
    if (checkedBooks[index]) {
      price.value += books[index].bookPrice ?? 0;
    } else {
      price.value -= books[index].bookPrice ?? 0;
    }
  }

  void checkPackage(int index) {
    checkedPackages[index] = !checkedPackages[index];
    if (checkedPackages[index]) {
      price.value += int.parse(packages[index].price ?? '0');
    } else {
      price.value -= int.parse(packages[index].price ?? '0');
    }
  }

  void createOrder() {
  }
}