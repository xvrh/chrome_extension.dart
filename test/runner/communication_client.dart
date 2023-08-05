import 'dart:convert';
import 'package:fetch_client/fetch_client.dart' as http;
import 'package:path/path.dart' as p;
import 'communication.dart';

class Client {
  final String baseUrl;
  final _client = http.FetchClient();

  Client({String? baseUrl}) : baseUrl = baseUrl ?? defaultServerUrl;

  Future<ServerInfo> serverInfo() async {
    return ServerInfo.fromJson(await _getJson('info'));
  }

  Future<void> log(String message) async {
    await _client.post(_uri('log'), body: jsonEncode(LogRequest(log: message)));
  }

  Future<void> terminate({required bool success}) async {
    await _client.post(_uri('terminate'),
        body: jsonEncode(TerminateRequest(success: success)));
  }

  Future<T> _getJson<T>(String path) async {
    var raw = await _client.read(_uri(path));
    return jsonDecode(raw) as T;
  }

  Uri _uri(String path) => Uri.parse(p.url.join(baseUrl, path));
}
