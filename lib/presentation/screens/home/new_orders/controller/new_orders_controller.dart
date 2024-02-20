import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_response.dart';

import '../../../../../domain/repository/repository.dart';

class NewOrdersController extends GetxController {

  final RxList<City> cities = RxList.empty();
  final RxList<Order> orders = RxList.empty();
  final RxList<bool> isOnlineList = RxList.empty();

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
        orders.value = remoteOrders.orders ?? [];
        cities.value = remoteOrders.cities ?? [];

        for (var element in orders) {
          int? payType = element.payType;
          int? payStatus = element.payStatus;
          if (payType == 1 && payStatus == 0) {
            orders.remove(element);
          } else if (payType == 1 && payStatus == 1) {
            isOnlineList.add(true);
          } else {
            isOnlineList.add(false);
          }
        }
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}