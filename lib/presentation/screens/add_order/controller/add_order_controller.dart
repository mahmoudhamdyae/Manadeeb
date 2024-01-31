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
  final RxList<int> booksQuantity = RxList.empty();
  final RxList<int> packagesQuantity = RxList.empty();

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
        booksQuantity.value = List.generate(books.value.length, (index) => 1);
        packages.value = notesAndPackages.packages ?? [];
        checkedPackages.value = List.generate(packages.value.length, (index) => false);
        packagesQuantity.value = List.generate(packages.value.length, (index) => 1);
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

  void incrementCountBook(int index) {
    if (checkedBooks[index]) {
      booksQuantity[index]++;
      price.value += books[index].bookPrice ?? 0;
    }
  }

  void decrementCountBook(int index) {
    if (checkedBooks[index] && booksQuantity[index] != 1) {
      booksQuantity[index]--;
      price.value -= books[index].bookPrice ?? 0;
    }
  }

  void incrementCountPackage(int index) {
    if (checkedPackages[index]) {
      packagesQuantity[index]++;
      price.value += int.parse(packages[index].price ?? '0');
    }
  }

  void decrementCountPackage(int index) {
    if (checkedPackages[index] && packagesQuantity[index] != 1) {
      packagesQuantity[index]--;
      price.value -= int.parse(packages[index].price ?? '0');
    }
  }
}