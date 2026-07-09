import 'package:dio/dio.dart';
import 'package:firebase_auth_app/core/constant/api_constant.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
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
        onRequest: (options, handler) {
          print("URl => ${options.uri}");
          print("Body => ${options.data}");
          handler.next(options);
        },
        onResponse: (response, handler) {
          print("STATUS => ${response.statusCode}");
          print("DATA => ${response.data}");

          handler.next(response);
        },
        onError: (error, handler) {
          print("ERROR => ${error.message}");

          handler.next(error);
        },
      ),
    );
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
