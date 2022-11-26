// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shelf_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShelfVOAdapter extends TypeAdapter<ShelfVO> {
  @override
  final int typeId = 5;

  @override
  ShelfVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShelfVO(
      shelfName: fields[0] as String?,
      bookList: (fields[1] as List?)?.cast<BookVO>(),
      index: fields[2] as String?,
      bookTiteList: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ShelfVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.shelfName)
      ..writeByte(1)
      ..write(obj.bookList)
      ..writeByte(2)
      ..write(obj.index)
      ..writeByte(3)
      ..write(obj.bookTiteList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShelfVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
