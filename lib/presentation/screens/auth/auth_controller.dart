import 'package:get/get.dart';

import '../../../domain/repository/repository.dart';

class AuthController extends GetxController {

  final Repository _repository;

  AuthController(this._repository);

  Future<void> signOut() async {
    return await _repository.signOut();
  }

  bool isUserLoggedIn() {
    return _repository.isUserLoggedIn();
  }

  String getUserName() {
    return _repository.getUserName();
  }
}