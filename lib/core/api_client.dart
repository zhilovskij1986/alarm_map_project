import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio();

  ApiClient() {
    dio.options.baseUrl = 'https://api.alerts.in.ua';

    dio.options.headers = {
      'Authorization': 'Bearer 89f7fd8b8eb24e67113b985852c3e087239724a4ab2203',
      'Accept': 'application/json',
    };
  }
}
