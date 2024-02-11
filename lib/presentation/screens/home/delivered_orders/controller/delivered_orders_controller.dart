import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_response.dart';
import 'package:manadeeb/presentation/screens/home/new_orders/controller/new_orders_controller.dart';

import '../../../../../domain/repository/repository.dart';

class DeliveredOrdersController extends GetxController {

  final RxList<City> cities = RxList.empty();
  final RxList<Order> orders = RxList.empty();
  final RxInt total1 = 0.obs;
  final RxInt total2 = 0.obs;
  final RxInt total3 = 0.obs;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Rx<RxStatus> _rStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get rStatus => _rStatus.value;

  final Repository _repository;
  DeliveredOrdersController(this._repository);

  @override
  void onInit() {
    super.onInit();
    cities.value = Get.find<NewOrdersController>().cities;
    getOrders();
  }

  void getOrders() {
    _status.value = RxStatus.loading();
    try {
      _repository.getCompleteOrders().then((remoteOrders) {
        _status.value = RxStatus.success();
        orders.value = remoteOrders.orders ?? [];
        setTotals();
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void setTotals() {
    setTotal1();
    setTotal2();
  }

  void setTotal1() {
    for (var element in orders) {
      total1.value += int.parse(element.priceAll ?? '');
    }
    total3.value += total1.value;
  }

  void setTotal2() {
    for (var element in orders) {
      City city = cities.firstWhere((elementCity) => elementCity.id == element.cityId);
      total2.value += city.deliverPrice ?? 0;
      total1.value -= city.deliverPrice ?? 0;
    }
  }
}