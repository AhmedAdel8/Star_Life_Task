import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:truee_balance_app/core/cache_helper/cache_helper.dart';
import 'package:truee_balance_app/core/cache_helper/cache_keys.dart';
import 'package:truee_balance_app/core/helper_functions/flutter_toast.dart';
import 'package:truee_balance_app/core/networks_helper/api_results/api_result.dart';
import 'package:truee_balance_app/core/networks_helper/errors/exceptions.dart';
import 'package:truee_balance_app/core/networks_helper/errors/failure.dart';
import 'package:truee_balance_app/core/utils/app_constants.dart';
import 'package:truee_balance_app/features/auth/data/api_services/api_services.dart';
import 'package:truee_balance_app/features/auth/data/models/user_data_model.dart';

class AuthRepository {
  final AuthApiServices authApiServices;

  AuthRepository(this.authApiServices);

  Future<ApiResult<String>> userLogin({
    required String email,
    required String password,
  }) async {
    final response = await authApiServices.login(
      email: email,
      password: password,
    );

    try {
      if (response!.statusCode == 200 || response.statusCode == 201) {
        UserDataModel model = UserDataModel.fromJson(response.data);

        await saveCaches(model);

        customToast(
          msg: 'loginSuccess'.tr(),
          color: Colors.green,
        );

        return const ApiResult.success('Login Success');
      } else {
        final rawError = response.data?['error'] ?? 'Login Failed';

        customToast(
          msg: rawError,
          color: Colors.red,
        );
      }
    } on DioException catch (e) {
      try {
        handleDioException(e);
      } on ServerException catch (ex) {
        return ApiResult.failure(ex.errorModel.message);
      }
    }

    return ApiResult.failure(
        FailureException(errMessage: 'Unexpected error occurred'));
  }

  Future<void> saveCaches(UserDataModel model) async {
    await CacheHelper.saveSecuredString(
        key: CacheKeys.userToken, value: model.data?.token ?? "");
    await CacheHelper.saveData(
        key: CacheKeys.userName, value: model.data?.name ?? "");
    await CacheHelper.saveData(
        key: CacheKeys.userEmail, value: model.data?.email ?? "");
    await CacheHelper.saveData(
        key: CacheKeys.userImage, value: model.data?.image ?? "");
    await CacheHelper.saveData(
        key: CacheKeys.userPhone, value: model.data?.phone ?? "");
    await CacheHelper.saveData(
        key: CacheKeys.type, value: model.data?.type ?? "");
    AppConstants.userToken =
        await CacheHelper.getSecuredString(key: CacheKeys.userToken);
  }
}
