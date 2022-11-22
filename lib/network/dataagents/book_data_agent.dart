import 'package:library_app/data/vos/over_view_vo.dart';
import 'package:library_app/network/responses/get_over_view_response.dart';

abstract class BookDataAgent {
  Future<OverViewVO?> getOverViewJson();
}
