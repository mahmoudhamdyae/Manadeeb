import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order.dart';

import '../../../../domain/repository/repository.dart';

class HomeController extends GetxController {

  final RxList<Order> orders = RxList.empty();

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  HomeController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getOrders();
  }

  void _getOrders() {
    _status.value = RxStatus.loading();
    try {
      _repository.getOrders().then((remoteOrders) {
        _status.value = RxStatus.success();
        orders.value = remoteOrders;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}