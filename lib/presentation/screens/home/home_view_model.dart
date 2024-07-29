part of 'home_import.dart';

class HomeViewModel {
  final Repository repository;
  HomeViewModel({required this.repository});

  final VelocityBloc<WeatherModel?> weatherbloc =
      VelocityBloc<WeatherModel?>(null);
  final TextEditingController _controller = TextEditingController();

  Future<void> fetchWeather() async {
    WeatherModel? data;
    try {
      var country = _controller.text;
      if (country.isEmpty) {
        final savedCountry = await getSavedCountryName();
        if (savedCountry != null && savedCountry.isNotEmpty) {
          data = await repository.weatherrepo
              .getWeatherData(country: savedCountry);
        } else {
          final position = await determinePosition();
          data = await repository.weatherrepo.getWeatherDataByCoords(
              latitude: position.latitude, longitude: position.longitude);
        }
      } else {
        await saveCountryName(country);
        data = await repository.weatherrepo.getWeatherData(country: country);
      }
      weatherbloc.onUpdateData(data);
    } catch (e) {
      weatherbloc.onFailedResponse(
          error: "Please enter the correct country name");
    }
  }

  Future<void> saveCountryName(String country) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('country_name', country);
  }

  Future<String?> getSavedCountryName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('country_name');
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
