import 'package:flutter/material.dart';
import 'package:universe_mobile_app/components/not_found_item.dart';
import 'package:universe_mobile_app/components/request_error.dart';
import 'package:universe_mobile_app/http/webclient.dart';
import 'package:universe_mobile_app/models/planet.dart';
import 'package:universe_mobile_app/screens/planets/form.dart';

class Universe extends StatefulWidget {
  const Universe({Key? key}) : super(key: key);

  @override
  State<Universe> createState() => _UniverseState();
}

class _UniverseState extends State<Universe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universe'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const PlanetForm()))
              .then(
            (value) {
              setState(() {});
            },
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText:
                      'Search for planets, constellations, stars, satellites, etc.',
                  hintText: 'Kleper X983',
                  hintStyle: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Universe items',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FutureBuilder<List<Planet>>(
                      future: findAll(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            break;
                          case ConnectionState.waiting:
                            break;
                          case ConnectionState.active:
                            break;
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return const Align(
                                alignment: Alignment.center,
                                child: RequestError(),
                              );
                            }
                            final List<Planet> planets = snapshot.data!;
                            return _renderWidgetOfPlanets(planets);
                        }
                        return const Text('Unknow error');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderWidgetOfPlanets(final List<Planet> planets) {
    if (planets.isEmpty) {
      return const Align(
        alignment: Alignment.center,
        child: NotFoundItem(
          customText: 'No planets found in your universe.',
        ),
      );
    }
    return _renderPlanetsListView(planets);
  }

  ListView _renderPlanetsListView(List<Planet> planets) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: planets.length,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black,
      ),
      itemBuilder: (context, index) {
        Planet planet = planets[index];
        return _renderPlanetsListViewItem(planet);
      },
    );
  }

  ListTile _renderPlanetsListViewItem(Planet planet) {
    return ListTile(
      title: Text(planet.name),
      subtitle: Text(planet.mass.toString()),
    );
  }
}
