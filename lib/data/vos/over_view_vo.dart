// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:library_app/data/vos/list_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'over_view_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_OVERVIEW_VO, adapterName: 'OverViewVOAdapter')
class OverViewVO {
  @JsonKey(name: 'bestsellers_date')
  @HiveField(0)
  final DateTime? bestsellersDate;

  @JsonKey(name: 'published_date')
  @HiveField(1)
  final DateTime? publishedDate;

  @JsonKey(name: 'published_date_description')
  @HiveField(2)
  final String? publishedDateDescription;

  @JsonKey(name: 'previous_published_date')
  @HiveField(3)
  final DateTime? previousPublishedDate;

  @JsonKey(name: 'next_published_date')
  @HiveField(4)
  final String? nextPublishedDate;

  @JsonKey(name: 'lists')
  @HiveField(5)
  final List<ListVO>? lists;

  OverViewVO({
    this.bestsellersDate,
    this.publishedDate,
    this.publishedDateDescription,
    this.previousPublishedDate,
    this.nextPublishedDate,
    this.lists,
  });

  factory OverViewVO.fromJson(Map<String, dynamic> json) =>
      _$OverViewVOFromJson(json);
  Map<String, dynamic> toJson() => _$OverViewVOToJson(this);

  @override
  String toString() {
    return 'OverViewVO(bestsellersDate: $bestsellersDate, publishedDate: $publishedDate, publishedDateDescription: $publishedDateDescription, previousPublishedDate: $previousPublishedDate, nextPublishedDate: $nextPublishedDate, lists: $lists)';
  }
}
