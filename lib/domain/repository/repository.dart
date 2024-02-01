import 'package:manadeeb/domain/models/order_details.dart';
import 'package:manadeeb/domain/models/package.dart';

import '../models/note.dart';
import '../models/notes_and_packages.dart';
import '../models/order_response.dart';

abstract class Repository {
  // Local Data Source
  Future<bool> isFirstTime();
  bool isUserLoggedIn();
  String getUserName();

  // Account Service
  Future<void> logIn(String phone, String password);
  Future<void> signOut();

  // Remote Data Source
  Future<OrderResponse> getOrders();
  Future<OrderDetailsResponse> getOrderDetails(int orderId);
  Future<Package> getPackage(int packageId);
  Future<void> receiveOrder(int orderId);
  Future<void> completeOrder(int orderId);
  Future<OrderResponse> getCurrentOrders();
  Future<OrderResponse> getCompleteOrders();
  Future<NotesResponse> getNotes(String marhala);
  Future<NotesAndPackages> getNotesAndPackages();
  Future<void> tawreed(int bookId);
}