// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'list_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_LIST_VO,adapterName: 'ListVOAdapter')
class ListVO {
  final int? listId;
  final String? listName;
  final String? listNameEncoded;
  final String? displayName;
  final String? updated;
  final String? listImage;
  final String? listImageWidth;
  final String? listImageHeight;
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

  factory ListVO.fromJson(Map<String,dynamic> json) => _$ListVOFromJson(json);
  Map<String,dynamic> toJson()=> _$ListVOToJson(this);
}
