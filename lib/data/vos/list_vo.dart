// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'list_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_LIST_VO, adapterName: 'ListVOAdapter')
class ListVO {
  @JsonKey(name: 'list_id')
  @HiveField(0)
  final int? listId;
  @JsonKey(name: 'list_name')
  @HiveField(1)
  final String? listName;
  @JsonKey(name: 'list_name_encoded')
  @HiveField(2)
  final String? listNameEncoded;
  @JsonKey(name: 'display_name')
  @HiveField(3)
  final String? displayName;
  @JsonKey(name: 'updated')
  @HiveField(4)
  final String? updated;
  @JsonKey(name: 'list_image')
  @HiveField(5)
  final String? listImage;
  @JsonKey(name: 'list_image_width')
  @HiveField(6)
  final String? listImageWidth;
  @JsonKey(name: 'list_image_height')
  @HiveField(7)
  final String? listImageHeight;
  @JsonKey(name: 'books')
  @HiveField(8)
  final List<BookVO>? books;
  ListVO({
    this.listId,
    this.listName,
    this.listNameEncoded,
    this.displayName,
    this.updated,
    this.listImage,
    this.listImageWidth,
    this.listImageHeight,
    this.books,
  });

  factory ListVO.fromJson(Map<String, dynamic> json) => _$ListVOFromJson(json);
  Map<String, dynamic> toJson() => _$ListVOToJson(this);

  @override
  String toString() {
    return 'ListVO(listId: $listId, listName: $listName, listNameEncoded: $listNameEncoded, displayName: $displayName, updated: $updated, listImage: $listImage, listImageWidth: $listImageWidth, listImageHeight: $listImageHeight, books: $books)';
  }
}
