import 'package:json_annotation/json_annotation.dart';

part 'version_check_response.g.dart';

@JsonSerializable()
class GetVersionCheckResponse {
  final String version;
  @JsonKey(name: 'update_type')
  final String updateType;

  GetVersionCheckResponse({required this.version, required this.updateType});

  factory GetVersionCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$GetVersionCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetVersionCheckResponseToJson(this);
}
