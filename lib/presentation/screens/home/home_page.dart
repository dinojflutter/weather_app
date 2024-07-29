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
    super.initState();
    homeviewmodel = HomeViewModel(repository: context.read<Repository>());
    homeviewmodel.fetchWeather();
  }

  @override
  void dispose() {
    homeviewmodel._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColor.primarycolor,
        title: const Text("Weather App"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ));
              },
              child: const Icon(
                Icons.help,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
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
          const SizedBox(height: 50),
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
                    MainText(
                      text: "Location: ${state.data!.location.country}",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    MainText(
                      text: "Temperature: ${state.data!.current.tempC} °C",
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    MainText(
                      text: 'Condition: ${state.data!.current.condition.text}',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    Image.network(
                      'https:${state.data!.current.condition.icon}',
                    ),
                  ],
                );
              } else if (state is VelocityFailedState) {
                return Center(
                  child: Text(state.error,
                      style: const TextStyle(color: Colors.red, fontSize: 18)),
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
