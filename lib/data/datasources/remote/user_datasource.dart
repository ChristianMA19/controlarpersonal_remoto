import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/user.dart';
import '../../../domain/models/client.dart';
import 'package:http/http.dart' as http;

class UserDataSource {
  final String apiKey = 'KInGzV';
  final String apiKeyClient = 'Cekfgh';

  Future<List<User>> getUsers() async {
    List<User> users = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/datausers")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await http.get(request);
    logInfo(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      users = List<User>.from(data.map((x) => User.fromJson(x)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(users);
  }

  Future<List<Client>> getClients() async {
    List<Client> users = [];
    var request = Uri.parse("https://retoolapi.dev/Cekfgh/data")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await http.get(request);
    logInfo("holaaaaa");
    logInfo(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      users = List<Client>.from(data.map((x) => Client.fromJson(x)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(users);
  }

  Future<bool> addUser(User user) async {
    logInfo("Web service, Adding user");

    final response = await http.post(
      Uri.parse("https://retoolapi.dev/$apiKey/datausers"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> addClient(Client user) async {
    logInfo("Web service, Adding user");

    final response = await http.post(
      Uri.parse("https://retoolapi.dev/$apiKeyClient/data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> updateUser(User user) async {
    final response = await http.put(
      Uri.parse("https://retoolapi.dev/$apiKey/datausers/${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> updateClient(Client user) async {
    final response = await http.put(
      Uri.parse("https://retoolapi.dev/$apiKeyClient/data/${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> deleteClient(int id) async {
    final response = await http.delete(
      Uri.parse("https://retoolapi.dev/$apiKeyClient/data/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    
    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/datausers/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    
    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }
}
