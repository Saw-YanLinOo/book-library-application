// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/over_view_vo.dart';

part 'get_over_view_response.g.dart';

@JsonSerializable()
class GetOverViewResponse {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'copyright')
  final String? copyright;

  @JsonKey(name: 'num_results')
  final int? numResults;

  @JsonKey(name: 'results')
  final OverViewVO? results;

  GetOverViewResponse({
    this.status,
    this.copyright,
    this.numResults,
    this.results,
  });

  factory GetOverViewResponse.fromJson(Map<String, dynamic> json) =>
      _$GetOverViewResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetOverViewResponseToJson(this);
}
