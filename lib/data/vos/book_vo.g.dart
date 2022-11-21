// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookVO _$BookVOFromJson(Map<String, dynamic> json) => BookVO(
      ageGroup: json['age_group'] as String?,
      amazonProductUrl: json['amazon_product_url'] as String?,
      articleChapterLink: json['article_chapter_link'] as String?,
      author: json['author'] as String?,
      bookImage: json['book_image'] as String?,
      bookImageWidth: json['book_image_width'] as int?,
      bookImageHeight: json['book_image_height'] as int?,
      bookReviewLink: json['book_review_link'] as String?,
      contributor: json['contributor'] as String?,
      contributorNote: json['contributor_note'] as String?,
      createdDate: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      description: json['description'] as String?,
      firstChapterLink: json['first_chapter_link'] as String?,
      price: json['price'] as String?,
      primaryIsbn10: json['primary_isbn10'] as String?,
      primaryIsbn13: json['primary_isbn13'] as String?,
      bookUri: json['book_uri'] as String?,
      publisher: json['publisher'] as String?,
      rank: json['rank'] as int?,
      rankLastWeek: json['rank_last_week'] as int?,
      sundayReviewLink: json['suday_review_link'] as String?,
      title: json['title'] as String?,
      updatedDate: json['updated_date'] == null
          ? null
          : DateTime.parse(json['updated_date'] as String),
      weeksOnList: json['weeks_on_list'] as int?,
      openDate: json['openDate'] == null
          ? null
          : DateTime.parse(json['openDate'] as String),
      buyLinks: (json['buy_links'] as List<dynamic>?)
          ?.map((e) => BuyLinkVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookVOToJson(BookVO instance) => <String, dynamic>{
      'age_group': instance.ageGroup,
      'amazon_product_url': instance.amazonProductUrl,
      'article_chapter_link': instance.articleChapterLink,
      'author': instance.author,
      'book_image': instance.bookImage,
      'book_image_width': instance.bookImageWidth,
      'book_image_height': instance.bookImageHeight,
      'book_review_link': instance.bookReviewLink,
      'contributor': instance.contributor,
      'contributor_note': instance.contributorNote,
      'created_date': instance.createdDate?.toIso8601String(),
      'description': instance.description,
      'first_chapter_link': instance.firstChapterLink,
      'price': instance.price,
      'primary_isbn10': instance.primaryIsbn10,
      'primary_isbn13': instance.primaryIsbn13,
      'book_uri': instance.bookUri,
      'publisher': instance.publisher,
      'rank': instance.rank,
      'rank_last_week': instance.rankLastWeek,
      'suday_review_link': instance.sundayReviewLink,
      'title': instance.title,
      'updated_date': instance.updatedDate?.toIso8601String(),
      'weeks_on_list': instance.weeksOnList,
      'buy_links': instance.buyLinks,
      'openDate': instance.openDate?.toIso8601String(),
    };
