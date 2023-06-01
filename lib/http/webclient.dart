import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
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

String baseApi = dotenv.env['API_BASE_URL']!;
String baseUrl = '$baseApi/planets';
Encoding? utf8 = Encoding.getByName('UTF-8');

Future<List<Planet>> findAll([String? searchNameParam]) async {
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

  if(searchNameParam != null && searchNameParam.isNotEmpty){
    return findByName(planets, searchNameParam);
  }

  return planets;
}

List<Planet> findByName(List<Planet> planets, String searchNameParam) {
  return planets
      .where((planet) => planet.name
      .contains(searchNameParam))
      .toList();
}

Future<Planet> post(Planet planet) async {
  final Map<String, dynamic> planetMap = {
    'name': planet.name,
    'mass': planet.mass
  };

  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final String jsonRequest = jsonEncode(planetMap);
  final Response response = await client.post(
    Uri.parse(baseUrl),
    headers: headers,
    body: jsonRequest,
    encoding: utf8,
  );

  final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

  return Planet(
    jsonResponse['id'],
    jsonResponse['name'],
    jsonResponse['mass'],
  );
}

Future<Planet> findById(int id) async {
  final String endpoint = '$baseUrl/$id';
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  final Response response = await client.get(
    Uri.parse(endpoint),
    headers: headers,
  );

  final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  return Planet(
    jsonResponse['id'],
    jsonResponse['name'],
    jsonResponse['mass'],
  );
}

Future<bool> delete(int id) async {
  final String endpoint = '$baseUrl/$id';
  final Response response = await client.delete(
    Uri.parse(endpoint),
    encoding: utf8,
  );
  return response.statusCode == 204;
}

Future<Planet> put(int id, Planet planet) async {
  final String endpoint = '$baseUrl/$id';
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  final Map<String, dynamic> requestMap = {
    'id': planet.id,
    'name': planet.name,
    'mass': planet.mass
  };

  final String requestJson = jsonEncode(requestMap);
  final Response response = await client.put(
    Uri.parse(endpoint),
    headers: headers,
    body: requestJson,
    encoding: utf8,
  );

  final Map<String, dynamic> responseMap = jsonDecode(response.body);
  return Planet(
    responseMap['id'],
    responseMap['name'],
    responseMap['mass'],
  );
}
