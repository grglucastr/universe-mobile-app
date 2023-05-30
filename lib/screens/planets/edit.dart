import 'package:flutter/material.dart';
import 'package:universe_mobile_app/components/not_found_item.dart';
import 'package:universe_mobile_app/components/request_error.dart';
import 'package:universe_mobile_app/http/webclient.dart';
import 'package:universe_mobile_app/models/planet.dart';

class PlanetEdit extends StatefulWidget {
  final int planetId;
  final String planetName;

  const PlanetEdit(this.planetId, this.planetName, {Key? key})
      : super(key: key);

  @override
  State<PlanetEdit> createState() => _PlanetEditState();
}

class _PlanetEditState extends State<PlanetEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _massController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.planetName}'),
      ),
      body: FutureBuilder<Planet>(
        future: findById(widget.planetId),
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
                return const RequestError();
              }

              if (snapshot.hasData) {
                final Planet planet = snapshot.data!;
                _nameController.value = TextEditingValue(text: planet.name);
                _massController.value = TextEditingValue(text: planet.mass.toString());
                return _renderForm(context, planet);
              }

              return const NotFoundItem(
                customText:
                    'Planet not found. Universe is to big... We couldn\'t find it.',
              );
          }
          return const Text('Unknown error');
        },
      ),
    );
  }

  Padding _renderForm(BuildContext context, Planet planet) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            textInputAction: TextInputAction.next,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: TextField(
                controller: _massController,
                decoration: const InputDecoration(labelText: 'Mass'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) => _putPlanet(context)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () => _putPlanet(context),
                child: const Text('Save'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _putPlanet(BuildContext context) {
    post(Planet(
      0,
      _nameController.text,
      double.parse(_massController.text),
    )).then((value) => Navigator.of(context).pop());
  }
}
