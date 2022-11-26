// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_search_google_book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchGoogleBookResponse _$GetSearchGoogleBookResponseFromJson(
        Map<String, dynamic> json) =>
    GetSearchGoogleBookResponse(
      kind: json['kind'] as String?,
      totalItems: json['totalItems'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => GoogleBookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchGoogleBookResponseToJson(
        GetSearchGoogleBookResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'totalItems': instance.totalItems,
      'items': instance.items,
    };
