import 'package:flutter/material.dart';
import 'package:universe_mobile_app/components/loading.dart';
import 'package:universe_mobile_app/components/request_error.dart';
import 'package:universe_mobile_app/http/webclient.dart';
import 'package:universe_mobile_app/models/planet.dart';
import 'package:universe_mobile_app/screens/planets/edit.dart';
import 'package:universe_mobile_app/screens/universe.dart';

class PlanetDetail extends StatefulWidget {
  final int planetId;
  final String planetName;

  const PlanetDetail({
    Key? key,
    required this.planetId,
    required this.planetName,
  }) : super(key: key);

  @override
  State<PlanetDetail> createState() => _PlanetDetailState();
}

class _PlanetDetailState extends State<PlanetDetail> {
  bool deleted = false;
  String planetTitle = '';

  @override
  Widget build(BuildContext context) {
    planetTitle = widget.planetName;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          planetTitle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanetEdit(
                    widget.planetId,
                    widget.planetName,
                  ),
                ),
              ).then((value){
                setState(() {});
              });
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => buildAlertDialogConfirm(context),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 500))
            .then((value) => findById(widget.planetId)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Loading(
                customText: 'Loading planet details...',
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const RequestError();
              }
              if (snapshot.hasData) {
                Planet? planet = snapshot.data;
                planetTitle = planet!.name;
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

  AlertDialog buildAlertDialogConfirm(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: Text('Are sure to proceed delete planet ${widget.planetName}?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            delete(widget.planetId)
                .then((result) => setState(() => _redirectToUniverse(context)));
          },
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll<Color>(Colors.red)),
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  void _redirectToUniverse(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Universe()),
        (route) => false);
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
