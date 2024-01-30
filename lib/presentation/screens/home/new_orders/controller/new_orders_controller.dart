import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_response.dart';

import '../../../../../domain/repository/repository.dart';

class NewOrdersController extends GetxController {

  final Rx<City> city = City().obs;
  final RxList<Order> orders = RxList.empty();

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  NewOrdersController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  void getOrders() {
    _status.value = RxStatus.loading();
    try {
      _repository.getOrders().then((remoteOrders) {
        _status.value = RxStatus.success();
        orders.value = remoteOrders.orders ?? [];
        city.value = remoteOrders.city ?? City();
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}