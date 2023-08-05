// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerInfo _$ServerInfoFromJson(Map<String, dynamic> json) => ServerInfo(
      puppeteerUrl: json['puppeteerUrl'] as String,
      operatingSystem: json['operatingSystem'] as String,
    );

Map<String, dynamic> _$ServerInfoToJson(ServerInfo instance) =>
    <String, dynamic>{
      'puppeteerUrl': instance.puppeteerUrl,
      'operatingSystem': instance.operatingSystem,
    };

LogRequest _$LogRequestFromJson(Map<String, dynamic> json) => LogRequest(
      log: json['log'] as String,
    );

Map<String, dynamic> _$LogRequestToJson(LogRequest instance) =>
    <String, dynamic>{
      'log': instance.log,
    };

TerminateRequest _$TerminateRequestFromJson(Map<String, dynamic> json) =>
    TerminateRequest(
      success: json['success'] as bool,
    );

Map<String, dynamic> _$TerminateRequestToJson(TerminateRequest instance) =>
    <String, dynamic>{
      'success': instance.success,
    };
