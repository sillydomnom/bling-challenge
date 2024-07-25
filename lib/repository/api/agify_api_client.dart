import 'dart:convert';

import 'package:http/http.dart';

import 'models/agify_dto.dart';

class AgifyApiClient {
  final Client _httpClient;

  AgifyApiClient({
    required Client httpClient,
  }) : _httpClient = httpClient;

  Future<AgifyDTO> retrieveAgeForName(String name) async {
    final response =
        await _httpClient.get(Uri.parse('https://api.agify.io?name=$name'));

    return AgifyDTO.fromJson(jsonDecode(response.body));
  }
}
