import 'package:dio/dio.dart';
import 'package:truee_balance_app/core/cache_helper/cache_helper.dart';
import 'package:truee_balance_app/core/cache_helper/cache_keys.dart';
import 'package:truee_balance_app/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:truee_balance_app/core/networks_helper/dio_helper/end_points.dart';

class AuthApiServices {
  AuthApiServices(this._dioFactory);

  final DioHelper _dioFactory;

  /// Login
  Future<Response?> login({
    required String email,
    required String password,
  }) async {
    return _dioFactory.post(endPoint: EndPoints.login, data: {
      'email': email,
      'password': password,
      'fcm_token': CacheHelper.getData(key: CacheKeys.deviceToken),
    });
  }


}
