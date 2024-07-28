import 'package:dio/dio.dart';
import 'package:weather_app/data/data_source/remote/api_constant.dart';
import 'package:weather_app/data/data_source/remote/api_exception.dart';

class ApiClient {
  late Dio dio;
  late BaseOptions baseOptions;

  ApiClient() {
    baseOptions =
        BaseOptions(baseUrl: ApiConstant.mainurl); // Initialize baseOptions
    dio = Dio(baseOptions);
  }

  Options options = Options();

  Future<Response> getrequest({required String path}) async {
    try {
      var response = await dio.get(path);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(message: e.response!.statusCode);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
