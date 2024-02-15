import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:manadeeb/domain/models/notes_and_packages.dart';
import 'package:manadeeb/domain/models/order_response.dart';

import '../../core/constants.dart';
import '../../domain/models/note.dart';
import '../../domain/models/order_details.dart';
import '../../domain/models/package.dart';
import '../../presentation/resources/strings_manager.dart';
import '../network_info.dart';

abstract class RemoteDataSource {
  Future<dynamic> logIn(String phone, String password);
  Future<String> getFcmToken();
  void sendTokenAndUserId(int userId);

  Future<OrderResponse> getOrders(int id);
  Future<OrderDetailsResponse> getOrderDetails(int orderId);
  Future<Package> getPackage(int packageId);
  Future<void> receiveOrder(int orderId, int userId);
  Future<void> completeOrder(int orderId);
  Future<OrderResponse> getCurrentOrders(int userId);
  Future<OrderResponse> getCompleteOrders(int userId);
  Future<NotesResponse> getNotes(String marhala, int mandoobId);
  Future<NotesAndPackages> getNotesAndPackages();
  Future<void> tawreed(int bookId, int userId);
  Future<int> addNote(int userId, int bookId, String quantity, String price);
  Future<int> addPackage(int userId, int packageId, String quantity, String price);
  Future<void> delBook(int bookId);
  Future<void> delPackage(int packageId);
  Future<void> createOrder(String name, String phone, String cityId, String address, String price, int userId);
  Future<void> deleteAllCart(int userId);
  Future<void> sendData(List<int> booksIds, List<int> packagesIds, List<int> booksQuantity, List<int> packagesQuantity, int userId);
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
  Future<String> getFcmToken() async {
    String? token;
    await FirebaseMessaging.instance.deleteToken().then((value) async => token = await FirebaseMessaging.instance.getToken());
    return token ?? '';
  }

  @override
  void sendTokenAndUserId(int userId) async {
    getFcmToken().then((token) async {
      await _checkNetwork();
      String url = "${Constants.baseUrl}mandub/fcm-token?user_id=$userId&token=$token";
      await _dio.patch(url);
    });
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

  @override
  Future<NotesAndPackages> getNotesAndPackages() async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/books/packages/classes";
    final response = await _dio.get(url);

    NotesAndPackages notesAndPackages = NotesAndPackages.fromJson(response.data);
    return notesAndPackages;
  }

  @override
  Future<void> tawreed(int bookId, int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/books/station/to/quantity/$userId/$bookId";
    await _dio.post(url);
  }

  @override
  Future<int> addNote(int userId, int bookId, String quantity, String price) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/add/book/to/cart/$userId/$bookId?quantity=$quantity&price=$price";
    final response = await _dio.post(url);
    int cartId = response.data['book_cart']['id'];
    return cartId;
  }

  @override
  Future<int> addPackage(int userId, int packageId, String quantity, String price) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/add/package/to/cart/$userId/$packageId?quantity=$quantity&price=$price";
    final response = await _dio.post(url);
    int cartId = response.data['book_cart']['id'];
    return cartId;
  }

  @override
  Future<void> delBook(int bookId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/books/cart/delete/book/$bookId";
    await _dio.post(url);
  }

  @override
  Future<void> delPackage(int packageId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/books/cart/delete/package/$packageId";
    await _dio.post(url);
  }

  @override
  Future<void> createOrder(String name, String phone, String cityId, String address, String price, int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/books/cart/create/current/order/$userId/$cityId?buyer=$name&phone=$phone&price_all=$price&address=$address";
    await _dio.post(url);
  }

  @override
  Future<void> deleteAllCart(int userId) async {
    await _checkNetwork();

    String url = "${Constants.baseUrl}mandub/books/cart/delete/package/all/$userId";
    await _dio.post(url);
  }

  @override
  Future<void> sendData(List<int> booksIds, List<int> packagesIds, List<int> booksQuantity, List<int> packagesQuantity, int userId) async {
    await _checkNetwork();
    var items = [];

    int count = 0;
    for (int id in packagesIds) {
      await getPackage(id).then((package) {
        package.book?.forEach((element) {
          items.add({
            'id': element.id,
            'quantity': packagesQuantity[count],
          });
        });
      });
      count++;
    }

    int count2 = 0;
    for (var element in booksIds) {
      items.add({
        'id': element,
        'quantity': booksQuantity[count2],
      });
      count2++;
    }

    var body =  {
      'updates': items,
    };

    String url = "${Constants.baseUrl}mandub/update/quantity/from/book/current/order/$userId";
    await _dio.post(url, data: jsonEncode(body));
  }
}