import 'package:get/get.dart';

import '../../../../domain/models/order_details.dart';
import '../../../../domain/repository/repository.dart';
import '../../home/new_orders/controller/new_orders_controller.dart';

class OrderDetailsController extends GetxController {

  final Rx<OrderDetailsResponse> order = OrderDetailsResponse().obs;
  late final int orderId;
  late final int cityId;
  final RxBool isBook = false.obs;
  final RxBool isPackage = false.obs;
  final RxInt bookNo = 0.obs;
  final RxInt packageNo = 0.obs;
  final RxInt total = 0.obs;
  RxList<Book> books = RxList.empty();
  RxList<Map<String, dynamic>> packages = RxList.empty();

  final Rx<RxStatus> _status = Rx<RxStatus>(RxStatus.empty());
  RxStatus get status => _status.value;

  final Rx<RxStatus> _rStatus = Rx<RxStatus>(RxStatus.empty());
  RxStatus get rStatus => _rStatus.value;

  final Repository _repository;
  OrderDetailsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> args = Get.arguments;
    orderId = args['order_id'];
    cityId = args['city_id'];
    getOrderDetails();
  }

  void getOrderDetails() {
    _status.value = RxStatus.loading();
    try {
      _repository.getOrderDetails(orderId).then((remoteOrderDetails) {
        var cities = Get.find<NewOrdersController>().cities;
        var city = cities.firstWhere((element) => element.id == cityId);
        total.value += city.deliverPrice ?? 0;

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

  Future<void> receiveOrder(int orderId) async {
    _rStatus.value = RxStatus.loading();
    try {
      await _repository.receiveOrder(orderId).then((remoteOrderDetails) {
        _rStatus.value = RxStatus.success();
      });
    } on Exception catch (e) {
      _rStatus.value = RxStatus.error(e.toString());
    }
  }

  Future<void> moveToCurrent(int orderId) async {
    _rStatus.value = RxStatus.loading();
    try {
      await _repository.completeOrder(orderId).then((value) {
        _rStatus.value = RxStatus.success();
      });
    } on Exception catch (e) {
      _rStatus.value = RxStatus.error(e.toString());
    }
  }
}