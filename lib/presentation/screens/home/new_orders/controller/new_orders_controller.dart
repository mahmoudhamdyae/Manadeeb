import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_response.dart';

import '../../../../../domain/repository/repository.dart';

class NewOrdersController extends GetxController {

  final RxList<City> cities = RxList.empty();
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

  Future<void> getOrders() async {
    _status.value = RxStatus.loading();
    try {
      await _repository.getOrders().then((remoteOrders) {
        _status.value = RxStatus.success();
        cities.value = remoteOrders.cities ?? [];

        orders.value = [];
        for (var element in remoteOrders.orders ?? []) {
          int? payType = element.payType;
          int? payStatus = element.payStatus;
          if (payType != 1 || payStatus != 0) {
            orders.add(element);
          }
        }
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}