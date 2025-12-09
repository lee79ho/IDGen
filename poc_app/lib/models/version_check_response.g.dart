// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_check_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVersionCheckResponse _$GetVersionCheckResponseFromJson(
        Map<String, dynamic> json) =>
    GetVersionCheckResponse(
      version: json['version'] as String,
      updateType: json['update_type'] as String,
    );

Map<String, dynamic> _$GetVersionCheckResponseToJson(
        GetVersionCheckResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'update_type': instance.updateType,
    };
