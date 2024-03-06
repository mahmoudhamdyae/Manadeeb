import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_response.dart';

import '../../../../../domain/repository/repository.dart';

class DeliveredOrdersController extends GetxController {

  final RxList<Order> orders = RxList.empty();
  final RxInt total1 = 0.obs;
  final RxInt total2 = 0.obs;
  final RxInt total3 = 0.obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  DeliveredOrdersController(this._repository);

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

  void getOrders() {
    _status.value = RxStatus.loading();
    try {
      _repository.getCompleteOrders().then((remoteOrders) {
        _status.value = RxStatus.success();
        orders.value = [];
        for (var element in remoteOrders.orders ?? []) {
          int? payType = element.payType;
          int? payStatus = element.payStatus;
          if (payType != 1 || payStatus != 0) {
            orders.add(element);
          }
        }
        total1.value = remoteOrders.orderPrice ?? 0;
        total2.value = remoteOrders.deliveryPrice ?? 0;
        total3.value = remoteOrders.allPrice ?? 0;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}