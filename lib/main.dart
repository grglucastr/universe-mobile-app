import 'package:flutter/material.dart';
import 'package:universe_mobile_app/http/webclient.dart';
import 'package:universe_mobile_app/models/planet.dart';

void main() {
  runApp(const UniverseMobileApp());
}

class UniverseMobileApp extends StatelessWidget {
  const UniverseMobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Planet> planets = List.empty(growable: true);

    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));
    planets.add(Planet(0, "planet x", 2131.22));

    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.deepPurple,
          ),
          primaryColor: Colors.deepPurple,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.amber)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Universe'),
        ),
        body: FutureBuilder<List<Planet>>(
          future: findAll(),
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if(snapshot.hasError){
                  return const Text('Something wrong happened during request.');
                }
                final List<Planet> planets  = snapshot.data!;
                return _renderWidgetOfPlanets(planets);
            }
            return const Text('Unknow error');
          }
        ),
      ),
    );
  }

  Widget _renderWidgetOfPlanets(final List<Planet> planets){
    if(planets.isEmpty){
      return const Text('No planet found in your universe.');
    }
    return _renderListOfPlanets(planets);
  }

  ListView _renderListOfPlanets(List<Planet> planets) {
    return ListView.separated(
      itemCount: planets.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
      ),
      itemBuilder: (context, index) {
        Planet planet = planets[index];
        return ListTile(
          title: Text(planet.name),
          subtitle: Text(planet.mass.toString()),
        );
      },
    );
  }
}
