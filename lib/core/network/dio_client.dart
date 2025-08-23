import 'package:dio/dio.dart';

class DioClient {
  static Dio? _instance;
  static Dio get instance {
    _instance ??= _createDio();
    return _instance!;
  }


  static Dio _createDio(){

    return Dio(
      BaseOptions(
        baseUrl: "https://api.coinpaprika.com/v1/",
        connectTimeout: 5000,
        receiveTimeout: 3000,
      )
    );
  }
}