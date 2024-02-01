import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/notes_and_packages.dart';
import 'package:manadeeb/domain/models/order_response.dart';
import 'package:manadeeb/domain/repository/repository.dart';
import 'package:manadeeb/presentation/screens/home/new_orders/controller/new_orders_controller.dart';

import '../../../resources/strings_manager.dart';

class AddOrderController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Rx<RxStatus> _orderStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get orderStatus => _orderStatus.value;

  final RxList<Books> books = RxList.empty();
  final RxList<Books> filteredNotes = RxList.empty();
  final RxList<Packages> filteredPackages = RxList.empty();
  final RxList<bool> checkedBooks = RxList.empty();
  final RxList<Packages> packages = RxList.empty();
  final RxList<bool> checkedPackages = RxList.empty();
  final RxInt price = 0.obs;
  final RxInt selectedCityId = (-1).obs;
  final RxList<int> booksQuantity = RxList.empty();
  final RxList<int> packagesQuantity = RxList.empty();

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
    _filterNotesAndPackages();
  }

  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController priceTextField = TextEditingController();
  final RxList<String> areas = [
    'المحافظة...',
    // 'حوالى',
    // 'مبارك الكبير',
    // 'الفروانية',
    // 'الأحمدى',
    // 'الجهراء',
    // 'العاصمة',
    // 'أم الهيمان',
    // 'الوفرة',
    // 'صباح الاحمد',
  ].obs;
  RxList<City> cities = RxList.empty();
  RxString selectedArea = 'المحافظة...'.obs;

  final Repository _repository;
  AddOrderController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getNotesAndPackages();
    cities.value = Get.find<NewOrdersController>().cities;
    cities.forEach((element) {
      areas.add(element.name ?? '');
    });
  }

  void _filterNotesAndPackages() {
    filteredNotes.value = books.where((element) => element.classroom == _sfoof[_selected.value]).toList();
    filteredPackages.value = packages.where((element) => element.class1 == _sfoof[_selected.value]).toList();
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
        _filterNotesAndPackages();
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void chooseArea(String newArea) {
    selectedArea.value = newArea;
    City city = cities.firstWhere((element) => element.name == newArea);
    selectedCityId.value = city.id ?? -1;
  }

  void checkNote(int index) {
    checkedBooks[index] = !checkedBooks[index];
    if (checkedBooks[index]) {
      price.value += books[index].bookPrice ?? 0;
      _repository.addNote(books[index].id ?? 0, booksQuantity[index].toString(), (booksQuantity[index] * (books[index].bookPrice ?? 0)).toString());
    } else {
      price.value -= (books[index].bookPrice ?? 0) * booksQuantity[index];
      booksQuantity[index] = 1;
      _repository.delBook(books[index].id ?? 0);
    }
  }

  void checkPackage(int index) {
    checkedPackages[index] = !checkedPackages[index];
    if (checkedPackages[index]) {
      price.value += int.parse(packages[index].price ?? '0');
      _repository.addPackage(packages[index].id ?? 0, booksQuantity[index].toString(), (booksQuantity[index] * (books[index].bookPrice ?? 0)).toString());
    } else {
      price.value -= int.parse(packages[index].price ?? '0') * packagesQuantity[index];
      packagesQuantity[index] = 1;
      _repository.delPackage(packages[index].id ?? 0);
    }
  }

  Future<void> createOrder() async {
    _orderStatus.value = RxStatus.loading();
    try {
      await _repository.createOrder(userName.text, phone.text, selectedCityId.toString(), address.text, priceTextField.text).then((value) {
        _orderStatus.value = RxStatus.success();
      });
    } on Exception catch (e) {
      _orderStatus.value = RxStatus.error(e.toString());
    }
  }

  void incrementCountBook(int index) {
    if (checkedBooks[index]) {
      booksQuantity[index]++;
      price.value += books[index].bookPrice ?? 0;
      _repository.addNote(books[index].id ?? 0, booksQuantity[index].toString(), (booksQuantity[index] * (books[index].bookPrice ?? 0)).toString());
    }
  }

  void decrementCountBook(int index) {
    if (checkedBooks[index] && booksQuantity[index] != 1) {
      booksQuantity[index]--;
      price.value -= books[index].bookPrice ?? 0;
      _repository.addNote(books[index].id ?? 0, booksQuantity[index].toString(), (booksQuantity[index] * (books[index].bookPrice ?? 0)).toString());
    }
  }

  void incrementCountPackage(int index) {
    if (checkedPackages[index]) {
      packagesQuantity[index]++;
      price.value += int.parse(packages[index].price ?? '0');
      _repository.addPackage(packages[index].id ?? 0, booksQuantity[index].toString(), (booksQuantity[index] * (books[index].bookPrice ?? 0)).toString());
    }
  }

  void decrementCountPackage(int index) {
    if (checkedPackages[index] && packagesQuantity[index] != 1) {
      packagesQuantity[index]--;
      price.value -= int.parse(packages[index].price ?? '0');
      _repository.addPackage(packages[index].id ?? 0, booksQuantity[index].toString(), (booksQuantity[index] * (books[index].bookPrice ?? 0)).toString());
    }
  }

  bool isBookInList(int index) {
    if (books[index].classroom == _sfoof[_selected.value]) {
      return true;
    }
    return false;
  }

  bool isPackageInList(int index) {
    if (packages[index].class1 == _sfoof[_selected.value]) {
      return true;
    }
    return false;
  }
}