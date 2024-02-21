import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_response.dart';

import '../../../../../domain/repository/repository.dart';

class CurrentOrdersController extends GetxController {

  final RxList<City> cities = RxList.empty();
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
    getOrders();
  }

  void getOrders() {
    _status.value = RxStatus.loading();
    try {
      _repository.getCurrentOrders().then((remoteOrders) {
        _status.value = RxStatus.success();
        orders.value = remoteOrders.orders ?? [];
        cities.value = remoteOrders.cities ?? [];

        for (var element in orders) {
          int? payType = element.payType;
          int? payStatus = element.payStatus;
          if (payType == 1 && payStatus == 0) {
            orders.remove(element);
          }
        }
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}