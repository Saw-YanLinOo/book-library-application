// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_over_view_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOverViewResponse _$GetOverViewResponseFromJson(Map<String, dynamic> json) =>
    GetOverViewResponse(
      status: json['status'] as String?,
      copyright: json['copyright'] as String?,
      numResults: json['num_results'] as int?,
      results: json['results'] == null
          ? null
          : OverViewVO.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetOverViewResponseToJson(
        GetOverViewResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.numResults,
      'results': instance.results,
    };
