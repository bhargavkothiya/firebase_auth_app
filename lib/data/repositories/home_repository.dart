import 'package:dio/dio.dart';
import 'package:firebase_auth_app/core/constant/api_constant.dart';
import 'package:firebase_auth_app/core/network/api_service.dart';
import 'package:firebase_auth_app/core/service/secure_storage_service.dart';
import 'package:firebase_auth_app/data/model/user_response_modal.dart';

import '../../core/exceptions/api_exception.dart';

class HomeRepository {
  final ApiService apiService;
  final SecureStorageService storage;

  HomeRepository({required this.apiService, required this.storage});

  Future<UserResponseModel> fetchData() async {
    try {
      final response = await apiService.get(ApiConstant.profileData);
      return UserResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException(e.response!.data["message"] ?? "Something went wrong");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
