import 'package:flutter/material.dart';
import 'package:flutterfiesta/helper.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ).copyWith(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://firebasestorage.googleapis.com/v0/b/ensemble-web-studio.appspot.com/o/demo_apps%2Fweather-app%2Fbg.jpg?alt=media&token=06b0efbb-6e79-44b9-be15-ea7015d40b34',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FutureBuilder(
                  future: getCurrentWeather(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    }

                    return Column(
                      children: [
                        const SizedBox(height: 8),
                        Text(snapshot.data?['name']),
                        Lottie.network(
                          getLottieAnimation(
                              snapshot.data?['weather'][0]['main']),
                          height: 200,
                        ),
                        Text('${snapshot.data?['main']['temp']}°',
                            style: const TextStyle(
                                fontSize: 60, fontWeight: FontWeight.w600)),
                        Text(snapshot.data?['weather'][0]['description']),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DescriptionCard(
                              value:
                                  '${snapshot.data?['main']['feels_like']} °',
                              label: 'Feels',
                            ),
                            const SizedBox(width: 8),
                            DescriptionCard(
                              value: '${snapshot.data?['main']['humidity']} %',
                              label: 'Humidity',
                            ),
                            const SizedBox(width: 8),
                            DescriptionCard(
                              value: '${snapshot.data?['wind']['speed']} km/h',
                              label: 'Wind',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  }),
            ),
            const SizedBox(height: 16),
            FutureBuilder(
                future: getForecast(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Today',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item =
                                  snapshot.data?['list'].elementAt(index);
                              return ForcastCard(item: item);
                            },
                            itemCount: snapshot.data?['list'].length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 8);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

class ForcastCard extends StatelessWidget {
  const ForcastCard({
    super.key,
    required this.item,
  });

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              formatTime(item['dt_txt']),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Image.network(
              'https://openweathermap.org/img/wn/${item['weather'][0]['icon']}@2x.png',
              width: 80,
            ),
            Text(
              '${item['main']['temp']}°',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ));
  }
}

class DescriptionCard extends StatelessWidget {
  final String value;
  final String label;

  const DescriptionCard({
    super.key,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
