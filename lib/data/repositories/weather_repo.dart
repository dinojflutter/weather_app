import '../../presentation/screens/home/home_model.dart';
import '../data_source/remote/api_client.dart';

class WeatherRepo extends ApiClient {
  WeatherRepo();

  Future<WeatherModel> getWeatherData({required String country}) async {
    try {
      final response = await getrequest(path: country);
      if (response.statusCode == 200) {
        final weatherData = WeatherModel.fromJson(response.data);
        print(weatherData);

        return weatherData;
      } else {
        throw Exception(
            "Failed to load weather data. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw Exception("An error occurred while fetching weather data: $e");
    }
  }

  Future<WeatherModel> getWeatherDataByCoords(
      {required double latitude, required double longitude}) async {
    try {
      final response = await getrequest(path: "$latitude,$longitude");
      if (response.statusCode == 200) {
        final weatherData = WeatherModel.fromJson(response.data);
        print(weatherData);

        return weatherData;
      } else {
        throw Exception(
            "Failed to load weather data. Status code: ${response.statusCode}");
      }
    } on Exception catch (e) {
      throw Exception("An error occurred while fetching weather data: $e");
    }
  }
}
