import 'package:get/get.dart';
import 'package:manadeeb/domain/repository/repository.dart';

class AddOrderController extends GetxController {

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  AddOrderController(this._repository);
}