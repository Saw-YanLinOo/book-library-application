import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/access_info_vo.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/sale_info_vo.dart';
import 'package:library_app/data/vos/search_info_vo.dart';
import 'package:library_app/data/vos/volume_info_vo.dart';

part 'google_book_vo.g.dart';

@JsonSerializable()
class GoogleBookVO {
  @JsonKey(name: 'kind')
  final String? kind;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'etag')
  final String? etag;
  @JsonKey(name: 'selfLink')
  final String? selfLink;
  @JsonKey(name: 'volumeInfo')
  final VolumeInfoVO? volumeInfo;
  @JsonKey(name: 'saleInfo')
  final SaleInfoVO? saleInfo;
  @JsonKey(name: 'accessInfo')
  final AccessInfoVO? accessInfo;
  @JsonKey(name: 'searchInfo')
  final SearchInfoVO? searchInfo;

  GoogleBookVO({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  });

  factory GoogleBookVO.fromJson(Map<String, dynamic> json) =>
      _$GoogleBookVOFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleBookVOToJson(this);

  BookVO toBookVO(GoogleBookVO gbook, String listName) {
    var book = BookVO();

    book.listName = listName;
    book.title = gbook.volumeInfo?.title;
    book.bookImage = gbook.volumeInfo?.imageLinks?.thumbnail;
    book.author = gbook.volumeInfo?.authors?.join(",");
    book.description = gbook.volumeInfo?.description;
    book.contributorNote = gbook.searchInfo?.textSnippet;
    book.publisher = gbook.volumeInfo?.publisher;
    book.ageGroup = gbook.volumeInfo?.printType;
    
    return book;
  }
}
