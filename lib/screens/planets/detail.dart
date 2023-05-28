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
        initialData: Planet(0,'',0.0),
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

              if(snapshot.hasError){
                return const RequestError();
              }

              if(snapshot.hasData){
                Planet? planet = snapshot.data;
                return Column(
                  children: [
                    const Text(
                      'ID: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(planetId.toString()),
                    const Text(
                      'Name: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(planetName),
                    const Text(
                      'Mass: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(planet!.mass.toString()),
                  ],
                );
              }
          }
          return const RequestError();
        },
      ),
    );
  }
}
