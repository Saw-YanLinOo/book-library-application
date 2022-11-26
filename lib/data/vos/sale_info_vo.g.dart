// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_info_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleInfoVO _$SaleInfoVOFromJson(Map<String, dynamic> json) => SaleInfoVO(
      country: json['country'] as String?,
      saleability: json['saleability'] as String?,
      isEbook: json['isEbook'] as bool?,
    );

Map<String, dynamic> _$SaleInfoVOToJson(SaleInfoVO instance) =>
    <String, dynamic>{
      'country': instance.country,
      'saleability': instance.saleability,
      'isEbook': instance.isEbook,
    };
