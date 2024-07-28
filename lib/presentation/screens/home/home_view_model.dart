part of 'home_import.dart';

class HomeViewModel {
  final Repository repository;
  HomeViewModel({required this.repository});

  final VelocityBloc<WeatherModel?> weatherbloc =
      VelocityBloc<WeatherModel?>(null);
  final TextEditingController _controller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<void> fetchWeather() async {
    WeatherModel? data;
    try {
      var country = _controller.text;
      if (country.isEmpty) {
        final position = await determinePosition();
        data = await repository.weatherrepo.getWeatherDataByCoords(
            latitude: position.latitude, longitude: position.longitude);
        weatherbloc.onUpdateData(data);
      } else {
        data = await repository.weatherrepo.getWeatherData(country: country);
        weatherbloc.onUpdateData(data);
      }
    } catch (e) {
      weatherbloc.onFailedResponse(error: e.toString());
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
