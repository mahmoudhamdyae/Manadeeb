import 'package:get/get.dart';

import '../../../../domain/models/order_details.dart';
import '../../../../domain/repository/repository.dart';
import '../../home/new_orders/controller/new_orders_controller.dart';

class OrderDetailsController extends GetxController {

  final Rx<OrderDetailsResponse> order = OrderDetailsResponse().obs;
  late final int orderId;
  final RxBool isBook = false.obs;
  final RxBool isPackage = false.obs;
  final RxInt bookNo = 0.obs;
  final RxInt packageNo = 0.obs;
  final RxInt total = RxInt(Get.find<NewOrdersController>().city.value.deliverPrice ?? 0);
  RxList<Book> books = RxList.empty();
  RxList<Map<String, dynamic>> packages = RxList.empty();

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
        remoteOrderDetails.orderdetails?.forEach((element) {
          if (element.book != null) {
            isBook.value = true;
            bookNo.value++;
            books.add(element.book!);
            total.value += element.book!.bookPrice! * (element.quantity ?? 0);
          } else if (element.package != null) {
            isPackage.value = true;
            packageNo.value++;
            packages.add(element.package!);
            total.value += (int.parse(element.package?['price'])) * (element.quantity ?? 0);
          }
        });
        _status.value = RxStatus.success();
        order.value = remoteOrderDetails;
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }

  void receiveOrder(int orderId) {
    _status.value = RxStatus.loading();
    try {
      _repository.receiveOrder(orderId).then((remoteOrderDetails) {
        _status.value = RxStatus.success();
      });
    } on Exception catch (e) {
      _status.value = RxStatus.error(e.toString());
    }
  }
}