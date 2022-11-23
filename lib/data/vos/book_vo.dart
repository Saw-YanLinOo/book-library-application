// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:library_app/data/vos/buy_link_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'book_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BOOK_VO, adapterName: 'BookVOAdapter')
class BookVO {
  @JsonKey(name: 'age_group')
  @HiveField(0)
  final String? ageGroup;

  @JsonKey(name: 'amazon_product_url')
  @HiveField(1)
  final String? amazonProductUrl;

  @JsonKey(name: 'article_chapter_link')
  @HiveField(2)
  final String? articleChapterLink;

  @JsonKey(name: 'author')
  @HiveField(3)
  final String? author;

  @JsonKey(name: 'book_image')
  @HiveField(4)
  final String? bookImage;

  @JsonKey(name: 'book_image_width')
  @HiveField(5)
  final int? bookImageWidth;

  @JsonKey(name: 'book_image_height')
  @HiveField(6)
  final int? bookImageHeight;

  @JsonKey(name: 'book_review_link')
  @HiveField(7)
  final String? bookReviewLink;

  @JsonKey(name: 'contributor')
  @HiveField(8)
  final String? contributor;

  @JsonKey(name: 'contributor_note')
  @HiveField(9)
  final String? contributorNote;

  @JsonKey(name: 'created_date')
  @HiveField(10)
  final DateTime? createdDate;

  @JsonKey(name: 'description')
  @HiveField(11)
  final String? description;

  @JsonKey(name: 'first_chapter_link')
  @HiveField(12)
  final String? firstChapterLink;

  @JsonKey(name: 'price')
  @HiveField(13)
  final String? price;

  @JsonKey(name: 'primary_isbn10')
  @HiveField(14)
  final String? primaryIsbn10;

  @JsonKey(name: 'primary_isbn13')
  @HiveField(15)
  final String? primaryIsbn13;

  @JsonKey(name: 'book_uri')
  @HiveField(16)
  final String? bookUri;

  @JsonKey(name: 'publisher')
  @HiveField(17)
  final String? publisher;

  @JsonKey(name: 'rank')
  @HiveField(18)
  final int? rank;

  @JsonKey(name: 'rank_last_week')
  @HiveField(19)
  final int? rankLastWeek;

  @JsonKey(name: 'suday_review_link')
  @HiveField(20)
  final String? sundayReviewLink;

  @JsonKey(name: 'title')
  @HiveField(21)
  final String? title;

  @JsonKey(name: 'updated_date')
  @HiveField(22)
  final DateTime? updatedDate;

  @JsonKey(name: 'weeks_on_list')
  @HiveField(23)
  final int? weeksOnList;

  @JsonKey(name: 'buy_links')
  @HiveField(24)
  final List<BuyLinkVO>? buyLinks;

  @HiveField(25)
  DateTime? openDate;

  @HiveField(26)
  String? listName;

  BookVO({
    this.ageGroup,
    this.amazonProductUrl,
    this.articleChapterLink,
    this.author,
    this.bookImage,
    this.bookImageWidth,
    this.bookImageHeight,
    this.bookReviewLink,
    this.contributor,
    this.contributorNote,
    this.createdDate,
    this.description,
    this.firstChapterLink,
    this.price,
    this.primaryIsbn10,
    this.primaryIsbn13,
    this.bookUri,
    this.publisher,
    this.rank,
    this.rankLastWeek,
    this.sundayReviewLink,
    this.title,
    this.updatedDate,
    this.weeksOnList,
    this.openDate,
    this.buyLinks,
    this.listName,
  });

  factory BookVO.fromJson(Map<String, dynamic> json) => _$BookVOFromJson(json);
  Map<String, dynamic> toJson() => _$BookVOToJson(this);

  @override
  String toString() {
    return 'BookVO(ageGroup: $ageGroup, amazonProductUrl: $amazonProductUrl, articleChapterLink: $articleChapterLink, author: $author, bookImage: $bookImage, bookImageWidth: $bookImageWidth, bookImageHeight: $bookImageHeight, bookReviewLink: $bookReviewLink, contributor: $contributor, contributorNote: $contributorNote, createdDate: $createdDate, description: $description, firstChapterLink: $firstChapterLink, price: $price, primaryIsbn10: $primaryIsbn10, primaryIsbn13: $primaryIsbn13, bookUri: $bookUri, publisher: $publisher, rank: $rank, rankLastWeek: $rankLastWeek, sundayReviewLink: $sundayReviewLink, title: $title, updatedDate: $updatedDate, weeksOnList: $weeksOnList, buyLinks: $buyLinks, openDate: $openDate, listName: $listName)';
  }
}
