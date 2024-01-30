import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_response.dart';

import '../../../../../domain/repository/repository.dart';

class CurrentOrdersController extends GetxController {

  final Rx<City> city = City().obs;
  final RxList<Order> orders = RxList.empty();

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Rx<RxStatus> _rStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get rStatus => _rStatus.value;

  final Repository _repository;
  CurrentOrdersController(this._repository);

  @override
  void onInit() {
    super.onInit();
    _getOrders();
  }

  void _getOrders() {
    _status.value = RxStatus.loading();
    try {
      _repository.getCurrentOrders().then((remoteOrders) {
        _status.value = RxStatus.success();
        orders.value = remoteOrders.orders ?? [];
        city.value = remoteOrders.city ?? City();
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void moveToCurrent(int orderId) {
    _rStatus.value = RxStatus.loading();
    try {
      _repository.completeOrder(orderId).then((value) {
        _rStatus.value = RxStatus.success();
      });
    } on Exception catch (e) {
      _rStatus.value = RxStatus.error(e.toString());
    }
  }
}