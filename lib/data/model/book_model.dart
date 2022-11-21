import 'package:library_app/data/vos/over_view_vo.dart';

abstract class BookModel {
  void getOverViewJson();
  Future<List<OverViewVO>?> getOverViewJsonFromDatabase();
}
