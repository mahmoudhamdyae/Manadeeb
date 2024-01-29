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
    });
  }

  @override
  Future<void> signOut() async {
    return await _localDataSource.signOut();
  }

  // Remote Data Source

  @override
  Future<OrderResponse> getOrders() {
    return _remoteDataSource.getOrders(_localDataSource.getUserId());
  }

  @override
  Future<OrderDetailsResponse> getOrderDetails(int orderId) {
    return _remoteDataSource.getOrderDetails(orderId);
  }

  @override
  Future<Package> getPackage(int packageId) {
    return _remoteDataSource.getPackage(packageId);
  }
}