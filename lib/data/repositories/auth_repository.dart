import 'package:dio/dio.dart';
import 'package:firebase_auth_app/core/constant/api_constant.dart';
import 'package:firebase_auth_app/core/exceptions/api_exception.dart';
import 'package:firebase_auth_app/core/network/api_service.dart';

import '../model/user_model.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository({required this.apiService});

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await apiService.post(
        ApiConstant.login,
        data: {"username": username, "password": password},
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(e.response!.data["message"] ?? "Something went wrong");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
