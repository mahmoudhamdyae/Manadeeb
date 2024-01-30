import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/local/local_data_source.dart';
import '../data/network_info.dart';
import '../data/remote/remote_data_source.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../presentation/screens/auth/auth_controller.dart';
import '../presentation/screens/auth/login/controller/login_controller.dart';
import '../presentation/screens/home/new_orders/controller/new_orders_controller.dart';
import '../presentation/screens/order_details/controller/order_details_controller.dart';
import '../presentation/screens/order_details/controller/package_controller.dart';

class GetXDi implements Bindings {

  @override
  Future<void> dependencies() async {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));

    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()), fenix: true);
    Get.put<Dio>(dio);

    await Get.putAsync<Box>(() async {
      final Box box = await Hive.openBox('auth');
      return box;
    }, permanent: true);

    // Data Sources and Repository
    Get.lazyPut<LocalDataSource>(() => LocalDataSourceImpl(Get.find<Box>()), fenix: true);
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSourceImpl(Get.find<NetworkInfo>(), Get.find<Dio>()), fenix: true);
    Get.lazyPut<Repository>(() => RepositoryImpl(Get.find<RemoteDataSource>(), Get.find<LocalDataSource>()), fenix: true);

    // Controllers
    Get.lazyPut<LoginController>(() => LoginController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<NewOrdersController>(() => NewOrdersController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<OrderDetailsController>(() => OrderDetailsController(Get.find<Repository>()), fenix: true);
    Get.lazyPut<PackageController>(() => PackageController(Get.find<Repository>()), fenix: true);
  }
}