// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'over_view_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OverViewVOAdapter extends TypeAdapter<OverViewVO> {
  @override
  final int typeId = 4;

  @override
  OverViewVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OverViewVO(
      bestsellersDate: fields[0] as DateTime?,
      publishedDate: fields[1] as DateTime?,
      publishedDateDescription: fields[2] as String?,
      previousPublishedDate: fields[3] as DateTime?,
      nextPublishedDate: fields[4] as String?,
      lists: (fields[5] as List?)?.cast<ListVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, OverViewVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.bestsellersDate)
      ..writeByte(1)
      ..write(obj.publishedDate)
      ..writeByte(2)
      ..write(obj.publishedDateDescription)
      ..writeByte(3)
      ..write(obj.previousPublishedDate)
      ..writeByte(4)
      ..write(obj.nextPublishedDate)
      ..writeByte(5)
      ..write(obj.lists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OverViewVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverViewVO _$OverViewVOFromJson(Map<String, dynamic> json) => OverViewVO(
      bestsellersDate: json['bestsellers_date'] == null
          ? null
          : DateTime.parse(json['bestsellers_date'] as String),
      publishedDate: json['published_date'] == null
          ? null
          : DateTime.parse(json['published_date'] as String),
      publishedDateDescription: json['published_date_description'] as String?,
      previousPublishedDate: json['previous_published_date'] == null
          ? null
          : DateTime.parse(json['previous_published_date'] as String),
      nextPublishedDate: json['next_published_date'] as String?,
      lists: (json['lists'] as List<dynamic>?)
          ?.map((e) => ListVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OverViewVOToJson(OverViewVO instance) =>
    <String, dynamic>{
      'bestsellers_date': instance.bestsellersDate?.toIso8601String(),
      'published_date': instance.publishedDate?.toIso8601String(),
      'published_date_description': instance.publishedDateDescription,
      'previous_published_date':
          instance.previousPublishedDate?.toIso8601String(),
      'next_published_date': instance.nextPublishedDate,
      'lists': instance.lists,
    };
