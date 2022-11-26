import 'package:json_annotation/json_annotation.dart';

part 'search_info_vo.g.dart';

@JsonSerializable()
class SearchInfoVO {
  @JsonKey(name: 'textSnippet')
  final String? textSnippet;
  SearchInfoVO({
    this.textSnippet,
  });

  factory SearchInfoVO.fromJson(Map<String, dynamic> json) =>
      _$SearchInfoVOFromJson(json);
  Map<String, dynamic> toJson() => _$SearchInfoVOToJson(this);
}
