import 'package:hive/hive.dart';

abstract class LocalDataSource {
  Future<bool> isFirstTime();
  Future<void> setUserLoggedIn();
  bool isUserLoggedIn();
  Future<void> signOut();
  Future<void> setUserId(int id);
  int getUserId();
  Future<void> setUserName(String name);
  String getUserName();
  void addCartId(int cartId);
  Future<List<int>> getAllCartId();
  void removeCartId(int cartId);
  void removeAllCartId();
}

const String keyIsFirstTime = "KEY_IS_FIRST_TIME";
const String keyIsUserLoggedIn = "KEY_IS_USER_LOGGED_IN";
const String keyUserId = "KEY_USER_ID";
const String keyUserName = "KEY_USER_NAME";
const String keyCart = "KEY_CART";

class LocalDataSourceImpl extends LocalDataSource {

  final Box _box;
  LocalDataSourceImpl(this._box);

  @override
  Future<bool> isFirstTime() async {
    bool isFirstTime = await _box.get(keyIsFirstTime, defaultValue: true);
    if (isFirstTime) {
      await _box.put(keyIsFirstTime, false);
    }
    return isFirstTime;
  }

  @override
  Future<void> setUserLoggedIn() async {
    return await _box.put(keyIsUserLoggedIn, true);
  }

  @override
  bool isUserLoggedIn() {
    return _box.get(keyIsUserLoggedIn, defaultValue: false);
  }

  @override
  Future<void> signOut() async {
    await _box.put(keyIsUserLoggedIn, false);
    setUserId(0);
    setUserName('');
  }

  @override
  Future<void> setUserId(int id) async {
    return await _box.put(keyUserId, id);
  }

  @override
  int getUserId() {
    return _box.get(keyUserId, defaultValue: 0);
  }

  @override
  Future<void> setUserName(String name) async {
    return await _box.put(keyUserName, name);
  }

  @override
  String getUserName() {
    return _box.get(keyUserName, defaultValue: '');
  }

  @override
  Future<List<int>> getAllCartId() async {
    Box<List<int>> box = await Hive.openBox<List<int>>('cart');
    return box.get(keyCart, defaultValue: []) ?? [];
  }

  @override
  Future<void> addCartId(int cartId) async{
    Box<List<int>> box = await Hive.openBox<List<int>>('cart');
    List<int> carts = await getAllCartId();
    carts.add(cartId);
    return await box.put(keyCart, carts);
  }

  @override
  void removeCartId(int cartId) async {
    Box<List<int>> box = await Hive.openBox<List<int>>('cart');
    List<int> carts = await getAllCartId();
    carts.remove(cartId);
    return await box.put(keyCart, carts);
  }

  @override
  void removeAllCartId() async {
    Box<List<int>> box = await Hive.openBox<List<int>>('cart');
    return await box.put(keyCart, []);
  }
}