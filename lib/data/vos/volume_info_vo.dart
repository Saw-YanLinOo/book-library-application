import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/image_links_vo.dart';
import 'package:library_app/data/vos/industry_identifier_vo.dart';
import 'package:library_app/data/vos/panelization_summary_vo.dart';
import 'package:library_app/data/vos/reading_modes_vo.dart';

part 'volume_info_vo.g.dart';

@JsonSerializable()
class VolumeInfoVO {
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'subtitle')
  final String? subtitle;
  @JsonKey(name: 'authors')
  final List<String>? authors;
  @JsonKey(name: 'publisher')
  final String? publisher;
  @JsonKey(name: 'publishedDate')
  final String? publishedDate;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'industryIdentifiers')
  final List<IndustryIdentifierVO>? industryIdentifiers;
  @JsonKey(name: 'readingModes')
  final ReadingModesVO? readingModes;
  @JsonKey(name: 'pageCount')
  final int? pageCount;
  @JsonKey(name: 'printType')
  final String? printType;
  @JsonKey(name: 'categories')
  final List<String>? categories;
  @JsonKey(name: 'maturityRating')
  final String? maturityRating;
  @JsonKey(name: 'allowAnonLogging')
  final bool? allowAnonLogging;
  @JsonKey(name: 'contentVersion')
  final String? contentVersion;
  @JsonKey(name: 'panelizationSummary')
  final PanelizationSummaryVO? panelizationSummary;
  @JsonKey(name: 'imageLinks')
  final ImageLinksVO? imageLinks;
  @JsonKey(name: 'language')
  final String? language;
  @JsonKey(name: 'previewLink')
  final String? previewLink;
  @JsonKey(name: 'infoLink')
  final String? infoLink;
  @JsonKey(name: 'canonicalValumeLink')
  final String? canonicalVolumeLink;

  VolumeInfoVO({
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printType,
    this.categories,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });

  factory VolumeInfoVO.fromJson(Map<String, dynamic> json) =>
      _$VolumeInfoVOFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeInfoVOToJson(this);
}
