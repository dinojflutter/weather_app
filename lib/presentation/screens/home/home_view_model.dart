part of 'home_import.dart';

class HomeViewModel {
  final Repository repository;
  HomeViewModel({required this.repository});

  final VelocityBloc<WeatherModel?> weatherbloc =
      VelocityBloc<WeatherModel?>(null);
  final TextEditingController _controller = TextEditingController();

  fetchWeather() async {
    var data = await repository.weatherrepo.getWeatherData();
    weatherbloc.onUpdateData(data);
  }
}
