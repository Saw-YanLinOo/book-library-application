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
    return ListVO();
  }

  @override
  void write(BinaryWriter writer, ListVO obj) {
    writer.writeByte(0);
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
      listId: json['listId'] as int?,
      listName: json['listName'] as String?,
      listNameEncoded: json['listNameEncoded'] as String?,
      displayName: json['displayName'] as String?,
      updated: json['updated'] as String?,
      listImage: json['listImage'] as String?,
      listImageWidth: json['listImageWidth'] as String?,
      listImageHeight: json['listImageHeight'] as String?,
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListVOToJson(ListVO instance) => <String, dynamic>{
      'listId': instance.listId,
      'listName': instance.listName,
      'listNameEncoded': instance.listNameEncoded,
      'displayName': instance.displayName,
      'updated': instance.updated,
      'listImage': instance.listImage,
      'listImageWidth': instance.listImageWidth,
      'listImageHeight': instance.listImageHeight,
      'books': instance.books,
    };
