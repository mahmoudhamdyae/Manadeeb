import 'package:manadeeb/domain/models/order_details.dart';

import '../models/order.dart';

abstract class Repository {
  // Local Data Source
  Future<bool> isFirstTime();
  bool isUserLoggedIn();
  String getUserName();

  // Account Service
  Future<void> logIn(String phone, String password);
  Future<void> signOut();

  // Remote Data Source
  Future<List<Order>> getOrders();
  Future<OrderDetailsResponse> getOrderDetails(int orderId);
}