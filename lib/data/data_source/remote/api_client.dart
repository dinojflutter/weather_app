import 'package:dio/dio.dart';
import 'package:weather_app/data/data_source/remote/api_constant.dart';
import 'package:weather_app/data/data_source/remote/api_exception.dart';

class ApiClient {
  final Dio dio = Dio();

  Future<Response> getrequest() async {
    try {
      var response = await dio.get(ApiConstant.mainurl);
      print(response);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print("Error with response");
        throw ApiException(message: e.response!.statusCode);
      } else {
        throw Exception(e.message);
      }
    }
  }
}
