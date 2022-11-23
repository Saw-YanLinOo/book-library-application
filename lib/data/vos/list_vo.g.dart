// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListVOAdapter extends TypeAdapter<ListVO> {
  @override
  final int typeId = 3;

  @override
  ListVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListVO(
      listId: fields[0] as int?,
      listName: fields[1] as String?,
      listNameEncoded: fields[2] as String?,
      displayName: fields[3] as String?,
      updated: fields[4] as String?,
      listImage: fields[5] as String?,
      listImageWidth: fields[6] as String?,
      listImageHeight: fields[7] as String?,
      books: (fields[8] as List?)?.cast<BookVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListVO obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.listId)
      ..writeByte(1)
      ..write(obj.listName)
      ..writeByte(2)
      ..write(obj.listNameEncoded)
      ..writeByte(3)
      ..write(obj.displayName)
      ..writeByte(4)
      ..write(obj.updated)
      ..writeByte(5)
      ..write(obj.listImage)
      ..writeByte(6)
      ..write(obj.listImageWidth)
      ..writeByte(7)
      ..write(obj.listImageHeight)
      ..writeByte(8)
      ..write(obj.books);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListVO _$ListVOFromJson(Map<String, dynamic> json) => ListVO(
      listId: json['list_id'] as int?,
      listName: json['list_name'] as String?,
      listNameEncoded: json['list_name_encoded'] as String?,
      displayName: json['display_name'] as String?,
      updated: json['updated'] as String?,
      listImage: json['list_image'] as String?,
      listImageWidth: json['list_image_width'] as String?,
      listImageHeight: json['list_image_height'] as String?,
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListVOToJson(ListVO instance) => <String, dynamic>{
      'list_id': instance.listId,
      'list_name': instance.listName,
      'list_name_encoded': instance.listNameEncoded,
      'display_name': instance.displayName,
      'updated': instance.updated,
      'list_image': instance.listImage,
      'list_image_width': instance.listImageWidth,
      'list_image_height': instance.listImageHeight,
      'books': instance.books,
    };
