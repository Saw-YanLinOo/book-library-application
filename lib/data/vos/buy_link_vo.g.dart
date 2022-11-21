// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy_link_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuyLinkVOAdapter extends TypeAdapter<BuyLinkVO> {
  @override
  final int typeId = 1;

  @override
  BuyLinkVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuyLinkVO();
  }

  @override
  void write(BinaryWriter writer, BuyLinkVO obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuyLinkVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyLinkVO _$BuyLinkVOFromJson(Map<String, dynamic> json) => BuyLinkVO(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$BuyLinkVOToJson(BuyLinkVO instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
