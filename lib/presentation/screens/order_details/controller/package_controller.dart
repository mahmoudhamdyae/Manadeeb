import 'package:get/get.dart';
import 'package:manadeeb/domain/models/package.dart';

import '../../../../domain/repository/repository.dart';

class PackageController extends GetxController {

  Rx<Package> package = Package().obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  PackageController(this._repository);

  void getPackage(int packageId) {
    _status.value = RxStatus.loading();
    try {
      _repository.getPackage(packageId).then((remotePackage) {
        _status.value = RxStatus.success();
        package.value = remotePackage;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}