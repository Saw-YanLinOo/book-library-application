import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/google_book_vo.dart';

part 'get_search_google_book_response.g.dart';

@JsonSerializable()
class GetSearchGoogleBookResponse {
  @JsonKey(name: 'kind')
  final String? kind;
  @JsonKey(name: 'totalItems')
  final int? totalItems;
  @JsonKey(name: 'items')
  final List<GoogleBookVO>? items;

  GetSearchGoogleBookResponse({
    this.kind,
    this.totalItems,
    this.items,
  });

  factory GetSearchGoogleBookResponse.fromJson(Map<String,dynamic> json)=> _$GetSearchGoogleBookResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GetSearchGoogleBookResponseToJson(this);


}
