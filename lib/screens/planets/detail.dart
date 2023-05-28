import 'package:flutter/material.dart';
import 'package:universe_mobile_app/components/request_error.dart';
import 'package:universe_mobile_app/http/webclient.dart';
import 'package:universe_mobile_app/models/planet.dart';

class PlanetDetail extends StatelessWidget {
  final int planetId;
  final String planetName;

  const PlanetDetail({
    Key? key,
    required this.planetId,
    required this.planetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(planetName)),
      body: FutureBuilder(
        initialData: Planet(0, '', 0.0),
        future: findById(planetId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const RequestError();
              }
              if (snapshot.hasData) {
                Planet? planet = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      _renderPlanetDetail(planet!),
                    ],
                  ),
                );
              }
          }
          return const RequestError();
        },
      ),
    );
  }

  Widget _renderPlanetDetail(Planet planet) {
    List<ListTile> tiles = List.empty(growable: true);
    _fillTilesList(tiles, planet);

    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black12,
          );
        },
        itemCount: tiles.length,
        itemBuilder: (BuildContext context, int index) {
          return tiles[index];
        },
      ),
    );
  }

  void _fillTilesList(List<ListTile> tiles, Planet planet) {
    tiles.add(ListTile(
      title: const Text('ID'),
      subtitle: Text(planet.id.toString()),
    ));
    tiles.add(ListTile(
      title: const Text('Name'),
      subtitle: Text(planet.name),
    ));
    tiles.add(ListTile(
      title: const Text('Mass'),
      subtitle: Text(planet.mass.toString()),
    ));
  }
}
