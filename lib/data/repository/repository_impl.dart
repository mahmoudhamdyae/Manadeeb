import 'package:manadeeb/domain/models/note.dart';
import 'package:manadeeb/domain/models/notes_and_packages.dart';
import 'package:manadeeb/domain/models/order_response.dart';
import 'package:manadeeb/domain/models/order_details.dart';
import 'package:manadeeb/domain/models/package.dart';

import '../../domain/repository/repository.dart';
import '../local/local_data_source.dart';
import '../remote/remote_data_source.dart';

class RepositoryImpl extends Repository {

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._remoteDataSource, this._localDataSource);

  // Local Data Source

  @override
  Future<bool> isFirstTime() {
    return _localDataSource.isFirstTime();
  }

  @override
  bool isUserLoggedIn() {
    return _localDataSource.isUserLoggedIn();
  }

  @override
  String getUserName() {
    return _localDataSource.getUserName();
  }

  // Account Service

  @override
  Future<void> logIn(String phone, String password) {
    return _remoteDataSource.logIn(phone, password).then((data) {
      _localDataSource.setUserId(data['user']['id']);
      _localDataSource.setUserName(data['user']['name']);
      _localDataSource.setUserLoggedIn();
      _remoteDataSource.sendTokenAndUserId(_localDataSource.getUserId());
    });
  }

  @override
  Future<void> signOut() async {
    return await _localDataSource.signOut();
  }

  // Remote Data Source

  @override
  Future<OrderResponse> getOrders() async {
    OrderResponse orderResponse = await _remoteDataSource.getOrders(_localDataSource.getUserId());
    List<int> citiesIds = [];
    orderResponse.cities?.forEach((element) {
      citiesIds.add(element.id ?? -1);
    });
    _localDataSource.saveCities(citiesIds);
    return orderResponse;
  }

  @override
  Future<OrderDetailsResponse> getOrderDetails(int orderId) {
    return _remoteDataSource.getOrderDetails(orderId);
  }

  @override
  Future<Package> getPackage(int packageId) {
    return _remoteDataSource.getPackage(packageId);
  }

  @override
  Future<void> receiveOrder(int orderId) {
    return _remoteDataSource.receiveOrder(orderId, _localDataSource.getUserId());
  }

  @override
  Future<void> completeOrder(int orderId) {
    return _remoteDataSource.completeOrder(orderId);
  }

  @override
  Future<OrderResponse> getCompleteOrders() {
    return _remoteDataSource.getCompleteOrders(_localDataSource.getUserId());
  }

  @override
  Future<OrderResponse> getCurrentOrders() {
    return _remoteDataSource.getCurrentOrders(_localDataSource.getUserId());
  }

  @override
  Future<NotesResponse> getNotes(String marhala) {
    return _remoteDataSource.getNotes(marhala, _localDataSource.getUserId());
  }

  @override
  Future<NotesAndPackages> getNotesAndPackages() {
    return _remoteDataSource.getNotesAndPackages();
  }

  @override
  Future<void> tawreed(int bookId) {
    return _remoteDataSource.tawreed(bookId, _localDataSource.getUserId());
  }

  @override
  Future<void> addNote(int bookId, String quantity, String price) async {
    int cartId = await _remoteDataSource.addNote(_localDataSource.getUserId(), bookId, quantity, price);
    _localDataSource.addCartId(cartId);
  }

  @override
  Future<void> addPackage(int packageId, String quantity, String price) async {
    int cartId = await _remoteDataSource.addPackage(_localDataSource.getUserId(), packageId, quantity, price);
    _localDataSource.addCartId(cartId);
  }

  @override
  Future<void> delBook(int bookId) async {
    return await _remoteDataSource.delBook(bookId);
  }

  @override
  Future<void> delPackage(int packageId) async {
    return await _remoteDataSource.delPackage(packageId);
  }

  @override
  Future<List<int>> getCitiesIds() {
    return _localDataSource.getCitiesIds();
  }

  @override
  Future<void> createOrder(String name, String phone, String cityId, String address, String price) async {
    await _remoteDataSource.createOrder(name, phone, cityId, address, price, _localDataSource.getUserId());
    _localDataSource.removeAllCartId();
  }

  @override
  Future<void> deleteAllCart() async {
    return await _remoteDataSource.deleteAllCart(_localDataSource.getUserId());
  }

  @override
  Future<void> sendData(List<int> booksIds, List<int> packagesIds, List<int> booksQuantity, List<int> packagesQuantity) {
    return _remoteDataSource.sendData(booksIds, packagesIds, booksQuantity, packagesQuantity, _localDataSource.getUserId());
  }
}