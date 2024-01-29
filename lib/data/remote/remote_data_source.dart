import 'package:dio/dio.dart';
import 'package:manadeeb/domain/models/order.dart';

import '../../core/constants.dart';
import '../../presentation/resources/strings_manager.dart';
import '../network_info.dart';

abstract class RemoteDataSource {
  Future<dynamic> logIn(String phone, String password);

  Future<List<Order>> getOrders(int id);
}

class RemoteDataSourceImpl extends RemoteDataSource {

  final NetworkInfo _networkInfo;
  final Dio _dio;
  RemoteDataSourceImpl(this._networkInfo, this._dio);

  _checkNetwork() async {
    if (!await _networkInfo.isConnected) {
      throw Exception(AppStrings.noInternetError);
    }
  }

  @override
  Future<dynamic> logIn(String phone, String password) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}auth/login?&password=$password&phone=$phone";
    final response = await _dio.post(url, data: {
      'password': password,
      'phone': phone,
    });

    final data = response.data;
    if (data["access_token"] == null) {
      throw Exception(AppStrings.wrongPhoneOrPassword);
    }
    if (data["user"]["user_type"] != 'mandub') {
      throw Exception(AppStrings.notMandoob);
    }
    return data;
  }

  @override
  Future<List<Order>> getOrders(int id) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}mandub/orders/$id";
    final response = await _dio.get(url);

    final data = response.data;

    List<Order> orders = [];
    for (var order in data["orders"]) {
      orders.add(Order.fromJson(order));
    }
    return orders;
  }
}