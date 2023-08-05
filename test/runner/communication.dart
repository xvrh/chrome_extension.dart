import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart' as shelf;
import 'package:shelf_static/shelf_static.dart';

part 'communication.g.dart';

final defaultServerUrl = const String.fromEnvironment('server-url');

class Server {
  final ServerInfo Function() onInfo;
  final void Function(LogRequest) onLog;
  final void Function(TerminateRequest) onTerminate;

  late final router = shelf.Router()
    ..get('/info', (request) => _info())
    ..post('/log', _log)
    ..post('/terminate', _terminate)
    ..mount('/static', createStaticHandler('test'));

  Server({
    required this.onInfo,
    required this.onLog,
    required this.onTerminate,
  });

  shelf.Response _wrapResponse(Object object) {
    return shelf.Response.ok(jsonEncode(object), headers: {
      'content-type': 'application/json',
    });
  }

  shelf.Response _info() {
    return _wrapResponse(onInfo());
  }

  Future<shelf.Response> _log(shelf.Request request) async {
    var log = LogRequest.fromJson(
        jsonDecode(await request.readAsString()) as Map<String, dynamic>);
    onLog(log);
    return shelf.Response.ok('');
  }

  Future<shelf.Response> _terminate(shelf.Request request) async {
    var terminate = TerminateRequest.fromJson(
        jsonDecode(await request.readAsString()) as Map<String, dynamic>);
    onTerminate(terminate);
    return shelf.Response.ok('');
  }
}

@JsonSerializable()
class ServerInfo {
  final String puppeteerUrl;
  final String operatingSystem;

  ServerInfo({required this.puppeteerUrl, required this.operatingSystem});

  factory ServerInfo.fromJson(Map<String, dynamic> json) =>
      _$ServerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ServerInfoToJson(this);
}

@JsonSerializable()
class LogRequest {
  final String log;

  LogRequest({required this.log});

  factory LogRequest.fromJson(Map<String, dynamic> json) =>
      _$LogRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LogRequestToJson(this);
}

@JsonSerializable()
class TerminateRequest {
  final bool success;

  TerminateRequest({required this.success});

  factory TerminateRequest.fromJson(Map<String, dynamic> json) =>
      _$TerminateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TerminateRequestToJson(this);
}
