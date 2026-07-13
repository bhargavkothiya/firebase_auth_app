import 'package:dio/dio.dart';
import 'package:firebase_auth_app/core/constant/storage_keys.dart';
import 'package:firebase_auth_app/core/exceptions/api_exception.dart';
import 'package:firebase_auth_app/core/service/secure_storage_service.dart';
import 'package:logger/logger.dart';

import '../constant/api_constant.dart';

class ApiService {
  final SecureStorageService storage;
  late final Dio dio;
  late final logger = Logger();

  ApiService({required this.storage}) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        sendTimeout: Duration(seconds: 30),
        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: StorageKeys.accessToken);
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          logger.d("URl => ${options.uri}");
          logger.d("Body => ${options.data}");
          logger.d("TOken => ${token}");

          handler.next(options);
        },
        onResponse: (response, handler) {
          logger.d("STATUS => ${response.statusCode}");
          logger.d("DATA => ${response.data}");

          handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response!.statusCode == 401) {
            final token = await refreshToken();
            if (token != null) {
              final request = error.requestOptions;
              request.headers["Authorization"] = "Bearer $token";
              final response = await dio.fetch(request);
              return handler.resolve(response);
            }
          }

          if (error.type == DioExceptionType.connectionError ||
              error.type == DioExceptionType.connectionTimeout) {
            return handler.reject(
              DioException(
                requestOptions: error.requestOptions,
                message: "No Internet Connection",
              ),
            );
          }

          logger.d("ERROR => ${error.message}");
          logger.d("Status Code => ${error.response!.statusCode}");
          handler.next(error);
        },
      ),
    );
  }

  Future<String?> refreshToken() async {
    final storedRefreshToken = await storage.read(
      key: StorageKeys.refreshToken,
    );
    logger.d("STORED REFRESH TOKEN => $storedRefreshToken");
    //if (storedRefreshToken == null) return null;

    try {
      final refreshDio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl));

      final response = await refreshDio.post(
        ApiConstant.refreshToken,
        data: {"refreshToken": storedRefreshToken},
      );

      final accessToken = response.data["accessToken"];
      final refreshToken = response.data["refreshToken"];

      await storage.write(key: StorageKeys.accessToken, value: accessToken);

      await storage.write(key: StorageKeys.refreshToken, value: refreshToken);
      logger.d("REFRESH RESPONSE => ${response.data}");
      return accessToken;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? headers}) async {
    return await dio.get(endpoint, options: Options(headers: headers));
  }

  Future<Response> post(String endpoint, {dynamic data}) async {
    return await dio.post(endpoint, data: data);
  }

  Future<Response> put(String endpoint, {dynamic data}) async {
    return await dio.put(endpoint, data: data);
  }

  Future<Response> delete(String endpoint) async {
    return await dio.delete(endpoint);
  }
}
