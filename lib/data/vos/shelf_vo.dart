// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/persistence/hive_constants.dart';

part 'shelf_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_SHELF_VO, adapterName: 'ShelfVOAdapter')
class ShelfVO {
  @HiveField(0)
  String? shelfName;
  @HiveField(1)
  List<BookVO>? bookList;
  @HiveField(2)
  String? index;
  @HiveField(3)
  List<String>? bookTiteList;
  @HiveField(4)
  List<Map<String, BookVO>>? bookMap;

  ShelfVO({
    this.shelfName,
    this.index,
    this.bookList,
    this.bookTiteList,
    this.bookMap,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShelfVO &&
        other.shelfName == shelfName &&
        listEquals(other.bookList, bookList) &&
        other.index == index &&
        listEquals(other.bookTiteList, bookTiteList) &&
        listEquals(other.bookMap, bookMap);
  }

  @override
  int get hashCode {
    return shelfName.hashCode ^
        bookList.hashCode ^
        index.hashCode ^
        bookTiteList.hashCode ^
        bookMap.hashCode;
  }
}
