import 'package:flutter/material.dart';
import 'package:universe_mobile_app/http/webclient.dart';
import 'package:universe_mobile_app/models/planet.dart';

class PlanetForm extends StatefulWidget {
  const PlanetForm({Key? key}) : super(key: key);

  @override
  State<PlanetForm> createState() => _PlanetFormState();
}

class _PlanetFormState extends State<PlanetForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _massController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planet Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              textInputAction: TextInputAction.next,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: TextField(
                  controller: _massController,
                  decoration: const InputDecoration(labelText: 'Mass'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) => _postPlanet(context)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () => _postPlanet(context),
                  child: const Text('Save'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _postPlanet(BuildContext context) {
    post(Planet(
      0,
      _nameController.text,
      double.parse(_massController.text),
    )).then((value) => Navigator.of(context).pop());
  }
}
