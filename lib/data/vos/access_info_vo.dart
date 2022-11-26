import 'package:json_annotation/json_annotation.dart';
import 'package:library_app/data/vos/epub_vo.dart';
import 'package:library_app/data/vos/pdf_vo.dart';

part 'access_info_vo.g.dart';

@JsonSerializable()
class AccessInfoVO {
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'viewabality')
  final String? viewability;
  @JsonKey(name: 'embeddable')
  final bool? embeddable;
  @JsonKey(name: 'publicDomain')
  final bool? publicDomain;
  @JsonKey(name: 'textToSpeechPermission')
  final String? textToSpeechPermission;
  @JsonKey(name: 'epub')
  final EpubVO? epub;
  @JsonKey(name: 'pdf')
  final PdfVO? pdf;
  @JsonKey(name: 'webReaderLink')
  final String? webReaderLink;
  @JsonKey(name: 'accessViewStatus')
  final String? accessViewStatus;
  @JsonKey(name: 'quoteSharingAllowed')
  final bool? quoteSharingAllowed;
  AccessInfoVO({
    this.country,
    this.viewability,
    this.embeddable,
    this.publicDomain,
    this.textToSpeechPermission,
    this.epub,
    this.pdf,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  });

  factory AccessInfoVO.fromJson(Map<String, dynamic> json) =>
      _$AccessInfoVOFromJson(json);
  Map<String, dynamic> toJson() => _$AccessInfoVOToJson(this);
}
