// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_book_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBookVO _$GoogleBookVOFromJson(Map<String, dynamic> json) => GoogleBookVO(
      kind: json['kind'] as String?,
      id: json['id'] as String?,
      etag: json['etag'] as String?,
      selfLink: json['selfLink'] as String?,
      volumeInfo: json['volumeInfo'] == null
          ? null
          : VolumeInfoVO.fromJson(json['volumeInfo'] as Map<String, dynamic>),
      saleInfo: json['saleInfo'] == null
          ? null
          : SaleInfoVO.fromJson(json['saleInfo'] as Map<String, dynamic>),
      accessInfo: json['accessInfo'] == null
          ? null
          : AccessInfoVO.fromJson(json['accessInfo'] as Map<String, dynamic>),
      searchInfo: json['searchInfo'] == null
          ? null
          : SearchInfoVO.fromJson(json['searchInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleBookVOToJson(GoogleBookVO instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'id': instance.id,
      'etag': instance.etag,
      'selfLink': instance.selfLink,
      'volumeInfo': instance.volumeInfo,
      'saleInfo': instance.saleInfo,
      'accessInfo': instance.accessInfo,
      'searchInfo': instance.searchInfo,
    };
