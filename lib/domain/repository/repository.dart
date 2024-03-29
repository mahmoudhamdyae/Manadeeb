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
  Future<void> addNote(int bookId, String quantity, String price);
  Future<void> addPackage(int packageId, String quantity, String price);
  Future<void> delBook(int bookId);
  Future<void> delPackage(int packageId);
  Future<List<int>> getCitiesIds();
  Future<void> createOrder(String name, String phone, String cityId, String address, String price);
  Future<void> deleteAllCart();
  Future<void> sendData(List<int> booksIds, List<int> packagesIds, List<int> booksQuantity, List<int> packagesQuantity);
}