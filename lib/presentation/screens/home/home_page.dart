part of 'home_import.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeViewModel homeviewmodel;

  @override
  void initState() {
    homeviewmodel = HomeViewModel(repository: context.read<Repository>());
    homeviewmodel.fetchWeather();
    super.initState();
  }

  @override
  void dispose() {
    homeviewmodel._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColor.primarycolor,
        title: const Text("Weather App"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: homeviewmodel._controller,
              decoration: InputDecoration(
                hintText: "Enter Country",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              homeviewmodel.fetchWeather();
            },
            child: const Text("Save Country"),
          ),
          BlocBuilder<VelocityBloc<WeatherModel?>,
              VelocityState<WeatherModel?>>(
            bloc: homeviewmodel.weatherbloc,
            builder: (context, state) {
              if (state is VelocityInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is VelocityUpdateState) {
                return Column(
                  children: [
                    Text('Temperature: ${state.data!.current.tempC} °C'),
                    Text('Condition: ${state.data!.current.condition.text}'),
                    Image.network(
                        'https:${state.data!.current.condition.icon}'),
                  ],
                );
              } else if (state is VelocityFailedState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
