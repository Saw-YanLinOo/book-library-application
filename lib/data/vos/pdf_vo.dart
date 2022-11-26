import 'package:json_annotation/json_annotation.dart';

part 'pdf_vo.g.dart';

@JsonSerializable()
class PdfVO {
  @JsonKey(name: 'isAvailable')
  final bool? isAvailable;
  @JsonKey(name: 'acsTokenLink')
  final String? acsTokenLink;
  PdfVO({
    this.isAvailable,
    this.acsTokenLink,
  });

  factory PdfVO.fromJson(Map<String,dynamic> json) => _$PdfVOFromJson(json);
  Map<String,dynamic> toJson() => _$PdfVOToJson(this);
}