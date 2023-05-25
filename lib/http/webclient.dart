import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:universe_mobile_app/models/planet.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

final Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

const String baseUrl = 'http://192.168.1.5:8080/api/v1/planets';

Future<List<Planet>> findAll() async {
  final Response response =
      await client.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 5));

  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Planet> planets = List.empty(growable: true);

  for (Map<String, dynamic> planetJson in decodedJson) {
    final Planet planet = Planet(
      planetJson['id'],
      planetJson['name'],
      planetJson['mass'],
    );
    planets.add(planet);
  }
  return planets;
}
