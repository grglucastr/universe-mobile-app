import 'package:flutter/material.dart';
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
        body: Container(
          child: ListView.builder(
            itemCount: planets.length,
            itemBuilder: (context, index) {
              Planet planet = planets[index];
              return Container(
                child: Text('Heres a planet ${planet.name}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
