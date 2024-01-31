import 'package:dio/dio.dart';
import 'package:manadeeb/domain/models/order_response.dart';

import '../../core/constants.dart';
import '../../domain/models/note.dart';
import '../../domain/models/order_details.dart';
import '../../domain/models/package.dart';
import '../../presentation/resources/strings_manager.dart';
import '../network_info.dart';

abstract class RemoteDataSource {
  Future<dynamic> logIn(String phone, String password);

  Future<OrderResponse> getOrders(int id);
  Future<OrderDetailsResponse> getOrderDetails(int orderId);
  Future<Package> getPackage(int packageId);
  Future<void> receiveOrder(int orderId, int userId);
  Future<void> completeOrder(int orderId);
  Future<OrderResponse> getCurrentOrders(int userId);
  Future<OrderResponse> getCompleteOrders(int userId);
  Future<NotesResponse> getNotes(String marhala, int mandoobId);
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
  Future<OrderResponse> getOrders(int id) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}mandub/orders/$id";
    final response = await _dio.get(url);

    final data = response.data;
    OrderResponse orderResponse = OrderResponse.fromJson(data);
    return orderResponse;
  }

  @override
  Future<OrderDetailsResponse> getOrderDetails(int orderId) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}mandub/order/details/$orderId";
    final response = await _dio.get(url);

    final data = response.data;

    OrderDetailsResponse order = OrderDetailsResponse.fromJson(data);
    return order;
  }

  @override
  Future<Package> getPackage(int packageId) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}mandub/order/details/package/$packageId";
    final response = await _dio.get(url);

    final data = response.data;

    PackageResponse package = PackageResponse.fromJson(data);
    return package.packagedetails?[0] ?? Package();
  }

  @override
  Future<void> receiveOrder(int orderId, int userId) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}order/new/to/current/$orderId/$userId";
    await _dio.post(url);
  }

  @override
  Future<void> completeOrder(int orderId) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}order/current/to/complate/$orderId";
    await _dio.post(url);
  }

  @override
  Future<OrderResponse> getCurrentOrders(int userId) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}order/current/orders/$userId";
    final response = await _dio.get(url);

    final data = response.data;
    OrderResponse orderResponse = OrderResponse.fromJson(data);
    return orderResponse;
  }

  @override
  Future<OrderResponse> getCompleteOrders(int userId) async {
    await _checkNetwork();
    String url = "${Constants.baseUrl}order/complate/orders/$userId";
    final response = await _dio.get(url);

    final data = response.data;
    OrderResponse orderResponse = OrderResponse.fromJson(data);
    return orderResponse;
  }

  @override
  Future<NotesResponse> getNotes(String marhala, int mandoobId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/books/quantity/$mandoobId";
    final response = await _dio.get(url);

    NotesResponse notesResponse = NotesResponse.fromJson(response.data);
    return notesResponse;
  }
}