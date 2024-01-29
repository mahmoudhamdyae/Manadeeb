import 'package:get/get.dart';

import '../../../../domain/models/order_details.dart';
import '../../../../domain/repository/repository.dart';

class OrderDetailsController extends GetxController {

  final Rx<OrderDetails> order = OrderDetails().obs;
  late final int orderId;

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Repository _repository;
  OrderDetailsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments;
    orderId = args['order_id'];
    _getOrderDetails();
  }

  void _getOrderDetails() {
    _status.value = RxStatus.loading();
    try {
      _repository.getOrderDetails(orderId).then((remoteOrderDetails) {
        _status.value = RxStatus.success();
        order.value = remoteOrderDetails;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}