import 'package:json_annotation/json_annotation.dart';

part 'epub_vo.g.dart';

@JsonSerializable()
class EpubVO {
  @JsonKey(name: 'isAvailable')
  final bool? isAvailable;
  EpubVO({
    this.isAvailable,
  });

  factory EpubVO.fromJson(Map<String,dynamic> json) => _$EpubVOFromJson(json);
  Map<String,dynamic> toJson() => _$EpubVOToJson(this);
}